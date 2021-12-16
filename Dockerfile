FROM ubuntu:20.04

RUN apt-get update && \
    apt-get install -y apt-transport-https ca-certificates curl
RUN curl -fsSLo /usr/share/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg
RUN echo "deb [signed-by=/usr/share/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | tee /etc/apt/sources.list.d/kubernetes.list
RUN apt-get update && \
    apt-get install -y kubectl

RUN useradd -ms /bin/bash  student
ADD entrypoint.sh /entrypoint.sh
RUN chmod 777 /entrypoint.sh



WORKDIR /home/student
USER student

ADD ../pwd /home/student/

ENTRYPOINT /entrypoint.sh
CMD ['sleep', '1000000']