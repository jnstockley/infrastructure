import toml
import datetime

import httpx
import pytest
from httpx import Client, Response

devices = toml.load("resources/config.toml")['Backups']


@pytest.mark.parametrize("devices", devices.items())
class TestBackups:
    client: Client

    @pytest.fixture(scope='function', autouse=True)
    def setup_method(self, devices):
        self.name = devices[0]
        parameters = devices[1]
        self.host = parameters['url']
        self.api_key = parameters['api_key']
        outdated_interval = int(parameters['outdated_interval'])
        self.outdated_time = (datetime.datetime.now() - datetime.timedelta(hours=outdated_interval)).timestamp()
        headers = {"Authorization": f"Bearer {self.api_key}"}
        self.client = httpx.Client(headers=headers, verify=False)

    def test_health_check(self):
        url = f"{self.host}/rest/noauth/health"
        response: Response
        ok = {"status": "OK"}

        with self.client as c:
            response = c.get(url)

        assert response is not None
        assert response.status_code == 200
        assert response.json() == ok, f"Health check failed for {self.name}"

    def test_paused(self):
        url = f"{self.host}/rest/config/folders"
        response: Response

        with self.client as c:
            response = c.get(url)

        assert response is not None
        assert response.status_code == 200

        folders = response.json()
        for folder in folders:
            data = dict(folder)
            assert "paused" in data
            assert "label" in data
            assert not data['paused'], f"{data['label']} is paused on {self.name}"

    def test_status(self):
        url = f"{self.host}/rest/stats/folder"
        response: Response
        with self.client as c:
            response = c.get(url)

        assert response is not None
        assert response.status_code == 200

        folders = response.json()
        for (folder, data) in folders.items():
            assert 'lastScan' in data
            last_scan = datetime.datetime.fromisoformat(data['lastScan']).timestamp()
            assert last_scan >= self.outdated_time, f"{folder} is out of sync on {self.name}"
