FROM ubuntu
# Cette image docker sert de demonstration pour le lab04.
# Ce n'est PAS une image destinée a une production ! :)
RUN apt-get update -y && \
    apt-get install -y python3-pip python3-dev
# We copy just the requirements.txt first to leverage Docker cache
COPY ./app/requirements.txt /app/requirements.txt
WORKDIR /app
RUN pip install -r requirements.txt
COPY ./app/ /app/
EXPOSE 80
ENTRYPOINT [ "python3" ]
CMD [ "app.py" ]
