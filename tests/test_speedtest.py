import toml
import datetime

import httpx
import pytest
from httpx import Client, Response

locations = toml.load("resources/config.toml")['Speedtest']


@pytest.mark.parametrize("locations", locations.items())
class TestSpeedtest:
    client: Client

    @pytest.fixture(scope='function', autouse=True)
    def setup_method(self, locations):
        self.name = locations[0]
        parameters = locations[1]
        self.host = parameters['url']
        self.api_key = parameters['api_key']
        self.upload_limit = parameters['upload_limit_megabits']
        self.download_limit = parameters['download_limit_megabits']
        headers = {"Authorization": f"Bearer {self.api_key}"}
        self.client = httpx.Client(headers=headers, verify=False)

    def test_speed(self):
        url = f"{self.host}/api/states"
        response: Response = None

        try:
            with self.client as c:
                response = c.get(url)
        except httpx.ConnectTimeout:
            assert response is not None, f'Cannot connect to {self.name}'

        assert response is not None
        assert response.status_code == 200

        download: float = 0.0
        upload: float = 0

        for entity in response.json():
            if entity['entity_id'] == 'sensor.speedtest_upload':
                upload = float(entity['state'])
            if entity['entity_id'] == 'sensor.speedtest_download':
                download = float(entity['state'])

        assert upload >= self.upload_limit
        assert download >= self.download_limit
