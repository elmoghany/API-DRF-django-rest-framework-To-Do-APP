#From python:3.12.4
FROM python:3.12.4-slim-bullseye
#FROM docker:27.0.3-dind-alpine3.20

ENV PYTHONUNBUFFERED=1

WORKDIR /moghany_dir

COPY todo_project/requirements.txt .

RUN pip install -r requirements.txt

COPY todo_project .

COPY docker-compose.yml .
COPY Dockerfile .

#COPY scripts .

#RUN install-docker.sh

#CMD ["python","manage.py","runserver","0.0.0.0:8000","noreload"]
