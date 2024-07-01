From python:3.12.4-slim

ENV PYTHONUNBUFFERED=1

WORKDIR /moghany_dir

COPY requirements.txt requirements.txt

RUN pip install -r requirements.txt

COPY . .

#CMD ["python","manage.py","runserver","0.0.0.0:8000","noreload"]
