import logging
import os
from datetime import timedelta, datetime

from airflow.decorators import task
from airflow.models import Variable
from airflow.models.dag import dag
from airflow.providers.http.hooks.http import HttpHook

logger = logging.getLogger(__name__)

default_args = {
    'owner': 'jackstockley',
    'retries': 0,
    'retry_delay': timedelta(minutes=5)
}

env = Variable.get("env")

connections = [
    HttpHook(http_conn_id='syncthing_photo_server', method='GET'),
    HttpHook(http_conn_id='syncthing_backup_server', method='GET'),
    HttpHook(http_conn_id='syncthing_synology', method='GET'),
    HttpHook(http_conn_id='syncthing_racknerd', method='GET'),
    HttpHook(http_conn_id='syncthing_iowa_hassio', method='GET'),
    HttpHook(http_conn_id='syncthing_chicago_hassio', method='GET'),
]

@dag(
    dag_id='Backup',
    description='Test syncthing backup clients to ensure they are healthy, and data is being backup up',
    schedule_interval='@once' if env == 'dev' else '0 */6 * * *',
    start_date=datetime(2024, 3, 4),
    default_args=default_args,
    catchup=False,
    tags=['backup', 'syncthing', 'infrastructure']
)
def backup():
    @task()
    def health_check():
        for connection in connections:
            if connection.test_connection()[0]:
                response = connection.run("/rest/noauth/health").json()
                assert response == {"status": "OK"}, f"Health check isn't ok, got: {response}"


    @task()
    def paused():
        pass

    @task()
    def status():
        pass

    @task()
    def errors():
        pass

    health_check()
    paused()
    status()
    errors()

backup()
