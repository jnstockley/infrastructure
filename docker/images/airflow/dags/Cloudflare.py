import logging
import os
from datetime import timedelta, datetime

from airflow.decorators import task
from airflow.models import Variable
from airflow.models.dag import dag


logger = logging.getLogger(__name__)

default_args = {
    'owner': 'jackstockley',
    'retries': 0,
    'retry_delay': timedelta(minutes=5)
}

env = Variable.get("env")

@dag(
    dag_id='Cloudflare',
    description='Test Cloudflare DNS records, and apps to make sure they have the correct permissions',
    schedule_interval='@once' if env == 'dev' else '0 */6 * * *',
    start_date=datetime(2024, 3, 4),
    default_args=default_args,
    catchup=False,
    tags=['cloudflare', 'infrastructure']
)
def cloudflare():
    @task()
    def test():
        pass

    test()

cloudflare()
