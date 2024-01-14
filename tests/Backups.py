import unittest
import datetime

import httpx
from httpx import Client


class BackupsTest(unittest.TestCase):
    api_key = "CHANGE THIS"

    ip_address = "CHANGE THIS"

    port = 8384

    client: Client

    outdated_time = (datetime.datetime.now() - datetime.timedelta(hours=12)).timestamp()

    def setUp(self):
        headers = {"Authorization": f"Bearer {self.api_key}"}
        self.client = httpx.Client(headers=headers)

    def test_health_check(self):
        url = f"http://{self.ip_address}:{self.port}/rest/noauth/health"

        ok = {"status": "OK"}

        with self.client as c:
            res = c.get(url)
            self.assertEqual(res.json(), ok, f"Health check failed for {self.ip_address}")

    def test_status(self):
        url = f"http://{self.ip_address}:{self.port}/rest/stats/folder"
        with self.client as c:
            res = c.get(url)
            folders = dict(res.json())
            for (folder, data) in folders.items():
                last_scan = datetime.datetime.fromisoformat(data['lastScan']).timestamp()

                self.assertGreaterEqual(last_scan, self.outdated_time, f"{folder} is out of sync on {self.ip_address}")

