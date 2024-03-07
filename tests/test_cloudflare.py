from datetime import datetime, timedelta
from pytz import timezone

import httpx

import logging
import toml

logging.getLogger().setLevel(logging.INFO)

cloudflare_api = "https://api.cloudflare.com/client/v4"


def make_request(url: str, method: str = 'GET', headers: dict = None, json: dict = None) -> dict | None:
    res = httpx.request(method, url, headers=headers, json=json)
    logging.info(f"Making {method} request to {url} with headers: {headers} and json: {json}")
    if res.status_code < 300:
        return res.json()
    logging.error(f"Request failed, status code: {res.status_code}, with error {res.json()}")
    return None


def get_dns_zone(zone_name: str, api_key: str) -> str | None:
    url = f"{cloudflare_api}/zones"
    headers = {'Authorization': f"Bearer {api_key}"}

    res_json = make_request(url, headers=headers)

    if 'result' in res_json:
        results = res_json['result']
        for result in results:
            if result['name'] == zone_name:
                return result['id']
    logging.error(f"Unable to get zone id with name {zone_name}")
    return None


def get_dns_record(zone_name: str, dns_name: str, api_key: str, ipv6: bool = False) -> dict | None:
    zone_id = get_dns_zone(zone_name, api_key)
    if zone_id is None:
        logging.error("Zone ID is None")
        return None

    url = f"{cloudflare_api}/zones/{zone_id}/dns_records"
    headers = {'Authorization': f"Bearer {api_key}"}

    res_json = make_request(url, headers=headers)

    if 'result' in res_json:
        results = res_json['result']
        for result in results:
            if result['name'] == dns_name and (not ipv6) and result['type'] == 'A':
                logging.debug("Selecting IPV4 Address")
                return result
            elif result['name'] == dns_name and ipv6 and result['type'] == 'AAAA':
                logging.debug("Selecting IPV6 Address")
                return result
    logging.error(f"Unable to get dns record id with name {dns_name}")
    return None


def get_zero_trust_application(zone_name: str, app_name: str, api_key: str) -> str | None:
    zone_id = get_dns_zone(zone_name, api_key)
    if zone_id is None:
        logging.error("Zone ID is None")
        return None
    headers = {
        'Authorization': f'Bearer {api_key}',
        'Content-Type': 'application/json',
    }
    url = f"{cloudflare_api}/zones/{zone_id}/access/apps"

    res_json = make_request(url, headers=headers)

    if 'result' in res_json:
        results = res_json['result']
        for app in results:
            if app['name'] == app_name:
                return app['id']
    logging.error(f"Unable to find app id for {app_name}")
    return None


def get_zero_trust_application_policies(zone_name: str, app_name: str, api_key: str):
    zone_id = get_dns_zone(zone_name, api_key)
    if zone_id is None:
        logging.error("Zone ID is None")
        return None
    app_id = get_zero_trust_application(zone_name, app_name, api_key)
    if app_id is None:
        logging.error("DNS record ID is None")
        return None

    headers = {
        'Authorization': f'Bearer {api_key}',
        'Content-Type': 'application/json',
    }
    url = f"{cloudflare_api}/zones/{zone_id}/access/apps/{app_id}/policies"

    res_json = make_request(url, headers=headers)

    if 'result' in res_json:
        results = res_json['result']
        for policy in results:
            return policy


cloudflare = toml.load("resources/config.toml")['Cloudflare']


class TestCloudflare:

    def setup_method(self):
        self.api_key = cloudflare['api_key']
        self.zone_name = cloudflare['zone_name']
        self.dns_records = cloudflare['dns_records']
        self.applications = cloudflare['applications']

    def test_dns_records(self):
        for dns_record in self.dns_records:
            record = get_dns_record(self.zone_name, dns_record, self.api_key)
            assert record is not None
            comment: str = record['comment']

            outdated_time = (datetime.now(timezone('US/Central')) - timedelta(hours=6))
            updated_at = datetime.strptime(comment[25:], '%Y-%m-%d %H:%M:%S.%f')

            assert updated_at.timestamp() >= outdated_time.timestamp()

    def test_zero_trust_app_policies(self):
        for app in self.applications:
            policy = get_zero_trust_application_policies(self.zone_name, app, self.api_key)
            assert policy is not None

            comment: str = policy['name']

            outdated_time = (datetime.now(timezone('US/Central')) - timedelta(hours=6))
            updated_at = datetime.strptime(comment[28:], '%Y-%m-%d %H:%M:%S.%f')

            assert updated_at.timestamp() >= outdated_time.timestamp()
