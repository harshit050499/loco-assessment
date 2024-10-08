FROM python:3.11-alpine AS build
WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
COPY app.py .

FROM python:3.11-alpine
WORKDIR /app
COPY --from=BUILD /usr/local/lib/python3.11/ /usr/local/lib/python3.11/
COPY --from=BUILD /app/app.py .
EXPOSE 80
ENTRYPOINT ["python","app.py"]

