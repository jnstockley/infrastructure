import time
from datetime import datetime

import httpx
from httpx import ConnectError

import logging

logging.getLogger().setLevel(logging.INFO)

ipv4_url = "https://ipinfo.io/json"
# ipv6_url = "https://v6.ipinfo.io/json"

cloudflare_api = "https://api.cloudflare.com/client/v4"

cloudflare_email = ""

cloudflare_api_key = ""


def make_request(url: str, method: str = 'GET', headers: dict = None, json: dict = None) -> dict | None:
    res = httpx.request(method, url, headers=headers, json=json)
    logging.info(f"Making {method} request to {url} with headers: {headers} and json: {json}")
    if res.status_code < 300:
        return res.json()
    logging.error(f"Request failed, status code: {res.status_code}, with error {res.json()}")
    return None


def get_public_ip(url: str = "https://ipinfo.io/json") -> str | None:
    try:
        res_json = make_request(url)
    except ConnectError:
        logging.warning(f"Unable to make connection to {url}")
        return None
    if 'ip' in res_json:
        return res_json['ip']
    logging.error(f"Error getting IP address from {url}")
    return None


def get_dns_zone(zone_name: str, email: str, api_key: str) -> str | None:
    url = f"{cloudflare_api}/zones"
    headers = {'X-Auth-Email': email, 'Authorization': f"Bearer {api_key}", 'X-Auth-Key': api_key}

    res_json = make_request(url, headers=headers)

    if 'result' in res_json:
        results = res_json['result']
        for result in results:
            if result['name'] == zone_name:
                return result['id']
    logging.error(f"Unable to get zone id with name {zone_name}")
    return None


def get_dns_record_id(zone_id: str, dns_name: str, email: str, api_key: str, ipv6: bool = False) -> str | None:
    url = f"{cloudflare_api}/zones/{zone_id}/dns_records"
    headers = {'X-Auth-Email': email, 'Authorization': f"Bearer {api_key}"}

    res_json = make_request(url, headers=headers)

    if 'result' in res_json:
        results = res_json['result']
        for result in results:
            if result['name'] == dns_name and (not ipv6) and result['type'] == 'A':
                logging.debug("Selecting IPV4 Address")
                return result['id']
            elif result['name'] == dns_name and ipv6 and result['type'] == 'AAAA':
                logging.debug("Selecting IPV6 Address")
                return result['id']
    logging.error(f"Unable to get dns record id with name {dns_name}")
    return None


def get_dns_record_ip(zone_name: str, dns_name: str, email: str, api_key: str) -> str | None:
    zone_id = get_dns_zone(zone_name, email, api_key)
    if zone_id is None:
        logging.error("Zone ID is None")
        exit(1)

    url = f"{cloudflare_api}/zones/{zone_id}/dns_records"
    headers = {'X-Auth-Email': email, 'Authorization': f"Bearer {api_key}"}

    res_json = make_request(url, headers=headers)

    if 'result' in res_json:
        results = res_json['result']
        for result in results:
            if result['name'] == dns_name:
                logging.debug("Selecting IPV4 Address")
                return result['content']
    logging.error(f"Unable to get dns record id with name {dns_name}")
    return None


def update_dns_record(new_ip: str, zone_name: str, dns_name: str, email: str, api_key: str, ipv6: bool = False,
                      proxied: bool = False) -> bool:
    zone_id = get_dns_zone(zone_name, email, api_key)
    if zone_id is None:
        logging.error("Zone ID is None")
        exit(1)
    dns_record_id = get_dns_record_id(zone_id, dns_name, email, api_key, ipv6)
    if dns_record_id is None:
        logging.error("DNS record ID is None")
        exit(1)
    url = f"{cloudflare_api}/zones/{zone_id}/dns_records/{dns_record_id}"
    headers = {
        'Authorization': f'Bearer {api_key}',
        'Content-Type': 'application/json',
    }
    body = {
        'content': new_ip,
        'name': dns_name,
        'proxied': proxied,
        'type': 'AAAA' if ipv6 else 'A',
        'comment': f"Updated automatically at {datetime.now()}",
        "ttl": 300
    }

    res_json = make_request(url, method='PATCH', headers=headers, json=body)

    return 'success' in res_json and res_json['success']


def get_zero_trust_application(zone_name: str, app_name: str, email: str, api_key: str):
    zone_id = get_dns_zone(zone_name, email, api_key)
    if zone_id is None:
        logging.error("Zone ID is None")
        exit(1)
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


def delete_all_app_policies(zone_name: str, app_name: str, email: str, api_key: str) -> bool:
    zone_id = get_dns_zone(zone_name, email, api_key)
    app_id = get_zero_trust_application(zone_name, app_name, email, api_key)
    if zone_id is None:
        logging.error("Zone ID is None")
        exit(1)
    if app_id is None:
        logging.error("DNS record ID is None")
        exit(1)
    headers = {
        'Authorization': f'Bearer {api_key}',
        'Content-Type': 'application/json',
    }
    url = f"{cloudflare_api}/zones/{zone_id}/access/apps/{app_id}/policies"

    res_json = make_request(url, headers=headers)

    if 'result' in res_json:
        results = res_json['result']
        for policy in results:
            policy_id = policy['id']
            if policy_id is not None:
                delete_url = f"{cloudflare_api}/zones/{zone_id}/access/apps/{app_id}/policies/{policy_id}"
                res_json = make_request(delete_url, method='DELETE', headers=headers)
                if 'result' in res_json:
                    logging.info(f"Deleted Policy ID: {policy_id} for App ID: {app_id}")
                    return True
    logging.error(f"Unable to delete policy(s) for app {app_name}")
    return False


def create_app_policy(zone_name: str, app_name: str, allowed_ips: list[str], email: str, api_key: str):
    zone_id = get_dns_zone(zone_name, email, api_key)
    app_id = get_zero_trust_application(zone_name, app_name, email, api_key)
    if zone_id is None:
        logging.error("Zone ID is None")
        exit(1)
    if app_id is None:
        logging.error("DNS record ID is None")
        exit(1)
    headers = {
        'Authorization': f'Bearer {api_key}',
        'Content-Type': 'application/json',
    }

    ips = []

    for allowed_ip in allowed_ips:
        ip = {
            'ip': {
                'ip': allowed_ip
            }
        }
        ips.append(ip)

    body = {'decision': 'bypass',
            'name': f'Allow Internal IPs added at {datetime.now()}',
            'include': ips}
    url = f"{cloudflare_api}/zones/{zone_id}/access/apps/{app_id}/policies"

    res_json = make_request(url, method='POST', headers=headers, json=body)

    if 'result' in res_json:
        logging.info(f'Added ips: {allowed_ips} to App: {app_name}, in Zone: {zone_name}')
        return True
    logging.error(f"Unable to add policy to app {app_name}")
    return False


@service
def cloudflare_ddns() -> bool:
    ipv4 = get_public_ip(ipv4_url)
    # ipv6 = get_public_ip(ipv6_url)

    updated_ipv4 = False
    update_ipv6 = True

    if ipv4 is not None:
        updated_ipv4 = update_dns_record(ipv4, "jstockley.com", "", cloudflare_email,
                                         cloudflare_api_key)

    # if ipv6 is not None:
    #    update_ipv6 = update_dns_record(ipv6, "jstockley.com", "", cloudflare_email,
    #                                    cloudflare_api_key, ipv6=True)

    return updated_ipv4 and update_ipv6

    '''logging.debug("Sleeping for 1 sec...")
    time.sleep(1)

    ips = ['']

    dns_records = ['iowa.vpn.jstockley.com', '']

    for dns_record in dns_records:
        ip = get_dns_record_ip("jstockley.com", dns_record, "", cloudflare_api_key)
        ips.append(ip)

    apps = ['']

    all_updated = True

    for app in apps:

        deleted = delete_all_app_policies("jstockley.com", app, "", cloudflare_api_key)

        created = create_app_policy("jstockley.com", app, ips, "", cloudflare_api_key)

        if not deleted and not created:
            all_updated = False

        logging.debug("Sleeping 1 sec in between apps...")
        time.sleep(1)

    return all_updated and updated_ipv4'''

# cloudflare_ddns()
