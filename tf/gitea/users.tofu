resource "gitea_user" "jack-stockley" {
  active                    = true
  admin                     = true
  allow_create_organization = false
  allow_git_hook            = false
  allow_import_local        = false
  username                  = "jackstockley"
  login_name                = "jackstockley"
  max_repo_creation         = 0
  password                  = var.gitea_password
  send_notification         = true
  email                     = "jack@jstockley.com"
  must_change_password      = false
  visibility                = "public"
}