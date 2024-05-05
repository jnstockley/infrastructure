import toml
from . import logger

import httpx
import pytest
from httpx import Client, Response

locations = toml.load("resources/config.toml")['Speedtest']


@pytest.mark.parametrize("location", locations.items())
class TestSpeedtest:
    client: Client

    @pytest.fixture(scope='function', autouse=True)
    def setup_method(self, location):
        self.name = location[0]
        parameters = location[1]
        self.host = parameters['url']
        self.api_key = parameters['api_key']
        self.upload_limit = parameters['upload_limit_megabits']
        self.download_limit = parameters['download_limit_megabits']
        headers = {"Authorization": f"Bearer {self.api_key}"}
        self.client = httpx.Client(headers=headers, verify=False)

    def test_speed(self):
        url = f"{self.host}/api/states"
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

        download: float = 0.0
        upload: float = 0

        for entity in response.json():
            if entity['entity_id'] == 'sensor.speedtest_upload':
                upload = float(entity['state'])
            if entity['entity_id'] == 'sensor.speedtest_download':
                download = float(entity['state'])

        assert upload >= self.upload_limit, f"Upload speed below limit: {upload} for location: {self.name}"
        assert download >= self.download_limit, f"Download speed below limit: {download} for location: {self.name}"
