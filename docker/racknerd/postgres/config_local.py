import os

AUTHENTICATION_SOURCES = ["oauth2"]
OAUTH2_AUTO_CREATE_USER = False
OAUTH2_CONFIG = [
    {
        "OAUTH2_NAME": "authentik",
        "OAUTH2_DISPLAY_NAME": "authentik",
        "OAUTH2_CLIENT_ID": os.environ["OAUTH_CLIENT_ID"],
        "OAUTH2_CLIENT_SECRET": os.environ["OAUTH_CLIENT_SECRET"],
        "OAUTH2_TOKEN_URL": "https://idp.jstockley.com/application/o/token/",
        "OAUTH2_AUTHORIZATION_URL": "https://idp.jstockley.com/application/o/authorize/",
        "OAUTH2_API_BASE_URL": "https://idp.jstockley.com/",
        "OAUTH2_USERINFO_ENDPOINT": "https://idp.jstockley.com/application/o/userinfo/",
        "OAUTH2_SERVER_METADATA_URL": "https://idp.jstockley.com/application/o/pg-admin-external/.well-known/openid-configuration",
        "OAUTH2_SCOPE": "openid email profile",
        "OAUTH2_USERNAME_CLAIM": "email",
        "OAUTH2_BUTTON_COLOR": "#fd4b2d",
    }
]
