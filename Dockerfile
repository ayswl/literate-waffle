FROM python:3.6-alpine3.9

COPY requirements.txt ./

RUN pip install --no-cache-dir -r requirements.txt

COPY $export_file ni.sql

COPY ni.py /

CMD ["python", "./ni.py"]