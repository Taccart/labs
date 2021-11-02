FROM python:3.7-alpine

# Cette image docker sert de demonstration pour le lab04.
# Ce n'est PAS une image destinée a une production ! :)

COPY ./app/requirements.txt /app/requirements.txt
WORKDIR /app
RUN pip install -r requirements.txt
COPY ./app/ /app/
ENTRYPOINT [ "python3" ]
CMD [ "app.py" ]
