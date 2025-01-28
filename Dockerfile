FROM python:3.9-slim

WORKDIR /FlaskAppJenkins

COPY requirements.txt requirements.txt

RUN pip install -r requirements.txt

COPY . .

EXPOSE 5000 80

CMD ["python", "main.py"]

