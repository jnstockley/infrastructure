
import pytest
import toml
from httpx import Client
from playwright.sync_api import sync_playwright

from get_credentials import Bitwarden

clients = toml.load("resources/config.toml")['Hassio']
bitwarden_config = toml.load("resources/config.toml")['Bitwarden']


@pytest.mark.parametrize("hassio", clients.items())
class TestHassio:
    client: Client

    @pytest.fixture(scope='function', autouse=True)
    def setup_method(self, hassio):
        self.name = hassio[0]
        parameters = hassio[1]
        self.url = parameters['url']
        self.credential_id = parameters['credential_id']
        self.bitwarden = Bitwarden(server=bitwarden_config['server'], username=bitwarden_config['username'],
                                   password=bitwarden_config['password'], client_id=bitwarden_config['client_id'],
                                   client_secret=bitwarden_config['client_secret'])
        self.cred = self.bitwarden.get_credential(self.credential_id)

    def test_device_errors(self):
        device_errors = []

        with sync_playwright() as p:
            browser = p.chromium.launch(headless=True)
            page = browser.new_page()
            page.goto(self.url)

            page.get_by_label("Username").click()
            page.get_by_label("Username").fill(self.cred.username)
            page.get_by_label("Password", exact=True).fill(self.cred.password)
            page.get_by_role("button", name="Log in").click()
            page.get_by_label("Two-factor authentication code").click()
            page.get_by_label("Two-factor authentication code").fill(self.cred.generate_totp())
            page.get_by_role("button", name="Log in").click()
            page.locator("a").filter(has_text="Settings").click()
            page.get_by_role("menuitem", name="Devices & services").click()

            # Wait for the selector to be available in the DOM
            page.wait_for_selector(".container ha-integration-card")

            assert page.query_selector(".container ha-integration-card") is not None, ("No element with the class of "
                                                                                       "'container' found")

            # Get all div elements with the classes 'secondary' and 'error'
            elements = page.query_selector_all("div.error")

            # Now, 'elements' is a list of div elements with the classes 'secondary' and 'error'
            for element in elements:
                parent_element = element.evaluate_handle("element => element.parentNode.parentNode.parentNode")
                device_errors.append(parent_element.query_selector('div.primary').inner_text())

        assert len(device_errors) == 0, f"Device errors found: {device_errors}"
