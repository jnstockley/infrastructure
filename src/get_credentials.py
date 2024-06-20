from dataclasses import dataclass, field

import pyotp
from bitwardentools import Client


@dataclass
class Credential:
    username: str
    password: str
    totp: str = field(default=None)

    def generate_totp(self):
        if self.totp is not None:
            return pyotp.TOTP(self.totp).now()
        return None


class Bitwarden:

    def __init__(self, server: str, username: str, password: str, client_id: str, client_secret: str):
        self.server = server
        self.username = username
        self.password = password
        self.client_id = client_id
        self.client_secret = client_secret

    def generate_login_payload(self, login_payload):
        login_payload.update({
            "client_id": self.client_id,
            "client_secret": self.client_secret,
            "scope": "api",
            "grant_type": "client_credentials"
        })

        return login_payload

    def get_credential(self, credential_id: str) -> Credential:


        client = Client(server=self.server, email=self.username, password=self.password, authentication_cb=self.generate_login_payload)

        cred = client.get_cipher(credential_id).json['data']

        return Credential(username=cred['username'], password=cred['password'], totp=cred['totp'])
