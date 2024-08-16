FROM apache/airflow:2.10.0-python3.12
COPY requirements.txt .
RUN pip3 install -r requirements.txt
COPY conf/webserver_config.py /opt/airflow
