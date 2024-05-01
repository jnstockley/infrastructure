import datetime

import httpx
import pytest
import toml
from httpx import Client, Response

clients = toml.load("resources/config.toml")['DNS']


@pytest.mark.parametrize("clients", clients.items())
class TestDNS:
    client: Client

    @pytest.fixture(scope='function', autouse=True)
    def setup_method(self, clients):
        self.name = clients[0]
        parameters = clients[1]
        self.client_id = parameters['client_id']
        self.api_key = parameters['api_key']
        self.host = parameters['host']
        outdated_interval = int(parameters['outdated_interval'])
        self.outdated_time = (datetime.datetime.now() - datetime.timedelta(hours=outdated_interval)).timestamp()
        headers = {'Authorization': f'Basic {self.api_key}'}
        self.client = httpx.Client(headers=headers)

    def test_client(self):
        url = f"{self.host}querylog?search={self.client_id}&limit=1"

        response: Response = None

        try:
            with self.client as c:
                response = c.get(url)
        except httpx.ConnectTimeout:
            assert response is not None, f'Cannot connect to {self.name}'

        assert response is not None
        assert response.status_code == 200

        requests = response.json()

        assert 'oldest' in requests

        last_request = datetime.datetime.fromisoformat(requests['oldest']).timestamp()
        assert last_request >= self.outdated_time, f"{self.name} last sent a DNS request at {last_request}"
