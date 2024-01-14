import toml
import datetime

import httpx
import pytest
from httpx import Client

devices_dict = toml.load("/config.toml")


@pytest.mark.parametrize("devices", devices_dict.items())
class TestBackups:
    port = 8384

    client: Client

    outdated_time = (datetime.datetime.now() - datetime.timedelta(hours=12)).timestamp()

    @pytest.fixture(scope='function', autouse=True)
    def setup_method(self, devices):
        self.host = devices[0]
        self.api_key = devices[1]
        headers = {"Authorization": f"Bearer {self.api_key}"}
        self.client = httpx.Client(headers=headers)

    def test_health_check(self):
        url = f"{self.host}/rest/noauth/health"

        ok = {"status": "OK"}

        with self.client as c:
            res = c.get(url)
            assert res.json() == ok, f"Health check failed for {self.host}"

    def test_status(self):
        url = f"{self.host}/rest/stats/folder"
        with self.client as c:
            res = c.get(url)
            folders = dict(res.json())
            for (folder, data) in folders.items():
                last_scan = datetime.datetime.fromisoformat(data['lastScan']).timestamp()

                assert last_scan >= self.outdated_time, f"{folder} is out of sync on {self.ip_address}"
