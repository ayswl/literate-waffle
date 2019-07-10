FROM python:3.6-alpine3.9

COPY requirements.txt ./

RUN pip install --no-cache-dir -r requirements.txt

COPY ni.py ni.sql /

CMD ["python", "./ni.py"]