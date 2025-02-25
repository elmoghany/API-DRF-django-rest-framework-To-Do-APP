#From python:3.12.4
FROM python:3.12.4-slim-bullseye

ENV PYTHONUNBUFFERED=1

WORKDIR /home/ubuntu/todo-project

COPY requirements.txt .

RUN pip install -r requirements.txt

COPY ./scripts ./scripts
COPY ./nginx ./nginx
COPY ./todo_project ./todo_project


#CMD ["python", "todo_project/manage.py", "runserver", "0.0.0.0:8000"]

#COPY scripts .

#RUN install-docker.sh

#CMD ["python","manage.py","runserver","0.0.0.0:8000","noreload"]
