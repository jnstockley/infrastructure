import datetime
from dataclasses import dataclass

import httpx
import pytest
import toml
from httpx import Client, Response
from . import logger

clients = toml.load("resources/config.toml")['DNS']


@pytest.mark.parametrize("dns_client", clients.items())
class TestDNS:
    client: Client

    @pytest.fixture(scope='function', autouse=True)
    def setup_method(self, dns_client):
        self.name = dns_client[0]
        parameters = dns_client[1]
        self.client_id = parameters['client_id']
        self.api_key = parameters['api_key']
        self.host = parameters['host']
        outdated_interval = int(parameters['outdated_interval'])
        self.outdated_time = (datetime.datetime.now() - datetime.timedelta(hours=outdated_interval)).timestamp()
        headers = {'Authorization': f'Basic {self.api_key}'}
        self.client = httpx.Client(headers=headers, verify=False)

    def test_client(self):
        url = f"{self.host}querylog?search={self.client_id}&limit=1"

        response: Response

        try:
            with self.client as c:
                logger.info(f"Sending request to: {url}")
                response = c.get(url)
        except httpx.ConnectTimeout as e:
            logger.critical(f"Unable to connect to host: {self.host}")
            logger.critical(e)
            assert False

        assert response.status_code == 200, f"Response code: {response.status_code}, when it should be 200"

        requests = response.json()

        assert 'oldest' in requests, f"Invalid response message, missing `oldest`: {requests}"

        last_request = datetime.datetime.fromisoformat(requests['oldest']).timestamp()
        logger.info(f"Last request received for {self.name}: {last_request}")
        assert last_request >= self.outdated_time, f"Last request received for {self.client_id}: {last_request}"
