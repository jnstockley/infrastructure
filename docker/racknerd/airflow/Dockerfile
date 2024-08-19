FROM apache/airflow:slim-2.10.0-python3.12
USER root
RUN apt-get update -y
RUN apt-get install iputils-ping -y
USER airflow
COPY requirements.txt .
RUN pip3 install -r requirements.txt
COPY conf/webserver_config.py /opt/airflow
