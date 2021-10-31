# Lab05 Déploiements Kubernetes
Vous allez avoir besoin d'un [client Kubernetes](https://kubernetes.io/fr/docs/reference/kubectl/) pour ce lab : `kubectl`.


kind: Deployment
  apiVersion: apps/v1
metadata:
name: flaskdemo
labels:
spec:
replicas: 1
strategy:
type: RollingUpdate
rollingUpdate:
maxUnavailable: 1
selector:
matchLabels:
app.kubernetes.io/component: webserver
release: {{ .Release.Name }}
{{- with .Values.labels }}
{{ toYaml . | indent 6 }}
{{- end }}
template:
metadata:
labels:
app.kubernetes.io/component: webserver
release: {{ .Release.Name }}
{{- with .Values.labels }}
{{ toYaml . | indent 8 }}
{{- end }}
annotations:
checksum/metadata-secret: {{ include (print $.Template.BasePath "/secrets/metadata-connection-secret.yaml") . | sha256sum }}
checksum/pgbouncer-config-secret: {{ include (print $.Template.BasePath "/secrets/pgbouncer-config-secret.yaml") . | sha256sum }}
checksum/airflow-config: {{ include (print $.Template.BasePath "/configmaps/configmap.yaml") . | sha256sum }}
checksum/extra-configmaps: {{ include (print $.Template.BasePath "/configmaps/extra-configmaps.yaml") . | sha256sum }}
checksum/extra-secrets: {{ include (print $.Template.BasePath "/secrets/extra-secrets.yaml") . | sha256sum }}
prometheus.io/scrape: "true"
prometheus.io/port: {{ .Values.ports.statsdScrape | quote }}
prometheus.io/path: "/{{ .Release.Name }}/admin/metrics"
{{- if .Values.airflowPodAnnotations }}
{{- toYaml .Values.airflowPodAnnotations | nindent 8 }}
{{- end }}
spec:
#      hostAliases:
#      - ip: "10.56.211.7"
#        hostnames:
#          - "daascoreairflowtst.blob.core.windows.net"
      serviceAccountName: {{ .Release.Name }}-webserver
      nodeSelector:
{{ toYaml $nodeSelector | indent 8 }}
affinity:
{{ toYaml $affinity | indent 8 }}
tolerations:
{{ toYaml $tolerations | indent 8 }}
restartPolicy: Always
securityContext:
runAsUser: {{ .Values.uid }}
fsGroup: {{ .Values.gid }}
{{- if or .Values.registry.secretName .Values.registry.connection }}
imagePullSecrets:
- name: {{ template "registry_secret" . }}
{{- end }}
initContainers:
- name: wait-for-airflow-migrations
image: {{ template "airflow_image" . }}
imagePullPolicy: {{ .Values.images.airflow.pullPolicy }}
resources:
limits:
cpu: 100m
memory: 256Mi
requests:
cpu: 100m
memory: 64Mi
args:
{{- include "wait-for-migrations-command" . | indent 10 }}
envFrom:
{{- include "custom_airflow_environment_from" . | default "\n  []" | indent 10 }}
env:
{{- include "custom_airflow_environment" . | indent 10 }}
{{- include "standard_airflow_environment" . | indent 10 }}
containers:
{{- if and (.Values.dags.blobSync.enabled) (not .Values.dags.persistence.enabled) }}
{{- include "blob_sync_container" . | indent 8 }}
{{- else if and (.Values.dags.gitSync.enabled) (not .Values.dags.persistence.enabled) }}
{{- include "git_sync_container" . | indent 8 }}
{{- else if and (.Values.dags.repoSync.enabled) (not .Values.dags.persistence.enabled) }}
{{- include "repo_sync_container" . | indent 8 }}
{{- end }}
- name: webserver
image: {{ template "airflow_image" . }}
imagePullPolicy: {{ .Values.images.airflow.pullPolicy }}
args: ["airflow", "webserver"]
resources:
{{ toYaml .Values.webserver.resources | indent 12 }}
volumeMounts:
- name: config
mountPath: {{ template "airflow_config_path" . }}
subPath: airflow.cfg
readOnly: true
{{- if .Values.webserver.webserverConfig }}
- name: config
mountPath: {{ template "airflow_webserver_config_path" . }}
subPath: webserver_config.py
readOnly: true
{{- end }}
{{- if .Values.scheduler.airflowLocalSettings }}
- name: config
mountPath: {{ template "airflow_local_setting_path" . }}
subPath: airflow_local_settings.py
readOnly: true
{{- end }}
{{- if or .Values.dags.repoSync.enabled .Values.dags.blobSync.enabled .Values.dags.gitSync.enabled .Values.dags.persistence.enabled }}
- name: dags
mountPath: {{ template "airflow_dags_mount_path" . }}
{{- end }}
{{- if .Values.webserver.extraVolumeMounts }}
{{ toYaml .Values.webserver.extraVolumeMounts | indent 12 }}
{{- end }}
ports:
- name: webserver-ui
containerPort: {{ .Values.ports.airflowUI }}
livenessProbe:
httpGet:
path: {{if .Values.config.webserver.base_url }}{{- with urlParse .Values.config.webserver.base_url }}{{ .path }}{{end}}{{end}}/health
port: {{ .Values.ports.airflowUI }}
{{- if .Values.config.webserver.base_url}}
httpHeaders:
- name: Host
value: {{ regexReplaceAll ":\\d+$" (urlParse .Values.config.webserver.base_url).host  "" }}
{{- end }}
initialDelaySeconds: {{ .Values.webserver.livenessProbe.initialDelaySeconds | default 15 }}
timeoutSeconds: {{ .Values.webserver.livenessProbe.timeoutSeconds | default 30 }}
failureThreshold: {{ .Values.webserver.livenessProbe.failureThreshold | default 200 }}
periodSeconds: {{ .Values.webserver.livenessProbe.periodSeconds | default 5 }}
readinessProbe:
httpGet:
path: {{if .Values.config.webserver.base_url }}{{- with urlParse .Values.config.webserver.base_url }}{{ .path }}{{end}}{{end}}/health
port: {{ .Values.ports.airflowUI }}
{{- if .Values.config.webserver.base_url}}
httpHeaders:
- name: Host
value: {{ regexReplaceAll ":\\d+$" (urlParse .Values.config.webserver.base_url).host  "" }}
{{- end }}
initialDelaySeconds: {{ .Values.webserver.readinessProbe.initialDelaySeconds | default 15 }}
timeoutSeconds: {{ .Values.webserver.readinessProbe.timeoutSeconds | default 30 }}
failureThreshold: {{ .Values.webserver.readinessProbe.failureThreshold | default 200 }}
periodSeconds: {{ .Values.webserver.readinessProbe.periodSeconds | default 5 }}
envFrom:
{{- include "custom_airflow_environment_from" . | default "\n  []" | indent 10 }}
env:
- name: AIRFLOW__WEBSERVER__SECRET_KEY
valueFrom:
secretKeyRef:
key: webserver-secret-key
name: airflow-webserver-secret
{{- include "custom_airflow_environment" . | indent 10 }}
{{- include "standard_airflow_environment" . | indent 10 }}
volumes:
- name: config
configMap:
name: {{ template "airflow_config" . }}
{{- if .Values.dags.persistence.enabled }}
- name: dags
persistentVolumeClaim:
claimName: {{ template "airflow_dags_volume_claim" . }}
{{- else if or .Values.dags.repoSync.enabled .Values.dags.blobSync.enabled .Values.dags.gitSync.enabled }}
- name: dags
emptyDir: {}
{{- if  .Values.dags.gitSync.sshKeySecret }}
{{- include "git_sync_ssh_key_volume" . | indent 8 }}
{{- end }}
{{- end }}
{{- if .Values.webserver.extraVolumes }}
{{ toYaml .Values.webserver.extraVolumes | indent 8 }}
{{- end }}
