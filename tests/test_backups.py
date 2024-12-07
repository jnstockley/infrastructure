import toml
import datetime

import httpx
import pytest
from httpx import Client, Response
from . import logger
import urllib.parse

backups = toml.load("resources/config.toml")['Backups']


@pytest.mark.parametrize("backup", backups.items())
class TestBackups:
    client: Client

    @pytest.fixture(scope='function', autouse=True)
    def setup_method(self, backup):
        self.name = backup[0]
        parameters = backup[1]
        self.host = parameters['url']
        self.api_key = parameters['api_key']
        outdated_interval = int(parameters['outdated_interval'])
        self.outdated_time = (datetime.datetime.now() - datetime.timedelta(hours=outdated_interval)).timestamp()
        headers = {"Authorization": f"Bearer {self.api_key}"}
        self.client = httpx.Client(headers=headers, verify=False, timeout=30)

    def test_health_check(self):
        url = f"{self.host}/rest/noauth/health"
        response: Response
        ok = {"status": "OK"}

        try:
            with self.client as c:
                logger.info(f"Sending request to: {url}")
                response = c.get(url)
        except httpx.ConnectTimeout as e:
            logger.critical(f"Unable to connect to host: {self.name}")
            logger.critical(e)
            assert False

        assert response.status_code == 200, f"{self.name} -> Response code: {response.status_code}, when it should be 200"
        assert response.json() == ok, f"{self.name} -> Health check isn't ok, get: {response.json()}"

    def test_paused(self):
        url = f"{self.host}/rest/config/folders"
        response: Response

        try:
            with self.client as c:
                logger.info(f"Sending request to: {url}")
                response = c.get(url)
        except httpx.ConnectTimeout as e:
            logger.critical(f"Unable to connect to host: {self.name}")
            logger.critical(e)
            assert False

        assert response.status_code == 200, f"{self.name} -> Response code: {response.status_code}, when it should be 200"

        folders = response.json()

        for folder in folders:
            data = dict(folder)
            assert "paused" in data, f"{self.name} -> Invalid response message missing `paused`: {folder}"
            assert "label" in data, f"{self.name} -> Invalid response message missing `label`: {folder}"
            assert not data['paused'], f"{self.name} -> {data['label']} is paused on {self.name}"

    def test_status(self):
        url = f"{self.host}/rest/stats/folder"
        response: Response

        try:
            with self.client as c:
                logger.info(f"Sending request to: {url}")
                response = c.get(url)
        except httpx.ConnectTimeout as e:
            logger.critical(f"Unable to connect to host: {self.name}")
            logger.critical(e)
            assert False

        assert response.status_code == 200, f"{self.name} -> Response code: {response.status_code}, when it should be 200"

        folders = response.json()
        for (folder, data) in folders.items():
            assert 'lastScan' in data, f"{self.name} -> Invalid response message missing `lastScan`: {data}"
            last_scan = datetime.datetime.fromisoformat(data['lastScan']).timestamp()
            assert last_scan >= self.outdated_time, f"{self.name} -> {folder} is out of sync on {self.name}, last synced: {last_scan}"

    '''def test_errors(self):
        url = f"{self.host}/rest/stats/folder"
        response: Response

        try:
            logger.info(f"Sending request to: {url}")
            response = self.client.get(url)
        except httpx.ConnectTimeout as e:
            logger.critical(f"Unable to connect to host: {self.host}")
            logger.critical(e)
            assert False

        assert response.status_code == 200, f"Response code: {response.status_code}, when it should be 200"

        folders = response.json()
        for (folder, data) in folders.items():
            url = f"{self.host}/rest/folder/errors?folder={urllib.parse.quote_plus(folder)}"
            try:
                logger.info(f"Sending request to: {url}")
                response = self.client.get(url)
            except httpx.ConnectTimeout as e:
                logger.critical(f"Unable to connect to host: {self.host}")
                logger.critical(e)
                assert False

            assert response.status_code == 200, f"Response code: {response.status_code}, when it should be 200"

            folder_data = response.json()

            if folder_data['errors'] is not None:
                for error in folder_data['errors']:
                    assert error['error'].startswith('hashing: '), f"Error found with {folder}: {folder_data['errors']}"
            else:
                assert folder_data['errors'] is None, f"Error found with {folder}: {folder_data['errors']}"'''
