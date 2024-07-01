From python:3.12.4-slim

ENV PYTHONUNBUFFERED=1

WORKDIR /moghany_dir

COPY todo_project/requirements.txt requirements.txt

RUN pip install -r requirements.txt

COPY todo_project .

#CMD ["python","manage.py","runserver","0.0.0.0:8000","noreload"]
