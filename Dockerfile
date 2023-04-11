FROM python:3.9-slim-buster

RUN pip install fastapi uvicorn

WORKDIR /app

COPY . .

CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "80"]

