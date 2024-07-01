From python:3.12.4-slim

WORKDIR /todo_project

COPY requirements.txt requirements.txt

RUN pip install -r requirements.txt

COPY . .

CMD ["python","manage.py","runserver","0.0.0.0:8000","noreload"]
