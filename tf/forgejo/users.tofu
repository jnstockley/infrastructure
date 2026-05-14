resource "forgejo_user" "jack-stockley" {
  active                    = true
  admin                     = true
  allow_create_organization = false
  allow_git_hook            = false
  allow_import_local        = false
  login                     = "jackstockley"
  login_name                = "jackstockley"
  max_repo_creation         = 0
  password                  = var.forgejo_password
  send_notify               = true
  email                     = "jack@jstockley.com"
  must_change_password      = false
  visibility                = "public"
}