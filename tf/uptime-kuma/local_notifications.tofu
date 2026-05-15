resource "uptimekuma_notification_nextcloudtalk" "nextcloud-talk" {
  provider           = uptimekuma.local
  name               = "Nextcloud Talk Notifications"
  host               = "https://${data.terraform_remote_state.cloudflare.outputs.nextcloud_dns_record_name}"
  conversation_token = var.nextcloud_talk_conversation_token
  bot_secret         = var.nextcloud_talk_local_secret
  is_active          = true
  is_default         = false
}

resource "uptimekuma_notification_smtp" "smtp-failover" {
  provider = uptimekuma.local
  name     = "SMTP Notifications"

  # Required fields
  host = "smtp.mail.me.com"
  from = "\"Uptime Kuma Photo Server\" <no-reply@jstockley.com>"
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