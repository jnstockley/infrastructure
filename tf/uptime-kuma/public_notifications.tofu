resource "uptimekuma_notification_nextcloudtalk" "public-nextcloud-talk" {
  provider           = uptimekuma.public
  name               = "Nextcloud Talk Notifications"
  host               = "https://${data.terraform_remote_state.cloudflare.outputs.nextcloud_dns_record_name}"
  conversation_token = var.nextcloud_talk_conversation_token
  bot_secret         = var.nextcloud_talk_public_secret
  is_active          = true
  is_default         = false
}

resource "uptimekuma_notification_smtp" "public-smtp-failover" {
  provider = uptimekuma.public
  name     = "SMTP Notifications"

  # Required fields
  host = "smtp.mail.me.com"
  from = "\"Uptime Kuma Racknerd\" <no-reply@jstockley.com>"
  to   = "jack@jstockley.com"

  # Optional: SMTP server configuration
  port             = 587
  secure           = false
  ignore_tls_error = false

  # Optional: SMTP authentication
  username = "jack.stockley@icloud.com"
  password = var.smtp_password

  # Optional: Email customization
  html_body = true

  is_active  = true
  is_default = false
}