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
            logger.critical(f"Unable to connect to host: {self.name}")
            logger.critical(e)
            assert False

        assert response.status_code == 200, (f"{self.name} -> Response code: {response.status_code}, when it should be "
                                             f"200")

        download: float = 0.0
        upload: float = 0

        for entity in response.json():
            if entity['entity_id'] == 'sensor.speedtest_upload':
                try:
                    upload = float(entity['state'])
                except Exception as e:
                    logger.error(f"{self.name} -> Unable to convert upload speed to float: {entity['state']}")
                    logger.error(e)
            if entity['entity_id'] == 'sensor.speedtest_download':
                try:
                    download = float(entity['state'])
                except Exception as e:
                    logger.error(f"{self.name} -> Unable to convert download speed to float: {entity['state']}")
                    logger.error(e)

        assert upload >= self.upload_limit, (f"{self.name} -> Upload speed below limit: {upload} for location: "
                                             f"{self.name}")
        assert download >= self.download_limit, (f"{self.name} -> Download speed below limit: {download} for location: "
                                                 f"{self.name}")
