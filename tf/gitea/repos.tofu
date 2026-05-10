data "terraform_remote_state" "cloudflare" {
  backend = "http"

  config = {
    address  = "https://gitlab.com/api/v4/projects/75895281/terraform/state/cloudflare"
    username = var.gitlab_username
    password = var.gitlab_access_token
  }
}

resource "gitea_repository" "address-book" {
  default_branch               = "master"
  description                  = "The backend for the Address Book REST API. Helps interface between java code and SQL database!"
  mirror                       = true
  migration_clone_addresse     = "https://github.com/jnstockley/AddressBook.git"
  migration_mirror_interval    = "8h0m0s"
  migration_releases           = true
  migration_service            = "github"
  migration_service_auth_token = var.github_token
  name                         = "AddressBook"
  private                      = false
  username                     = gitea_user.jack-stockley.username

  depends_on = [gitea_user.jack-stockley]
}

resource "gitea_repository" "address-book-cli" {
  default_branch               = "master"
  description                  = "An Address Book that is stored on a MySQL server and takes full advantage of CRUD!"
  mirror                       = true
  migration_clone_addresse     = "https://github.com/jnstockley/AddressBookCLI.git"
  migration_mirror_interval    = "8h0m0s"
  migration_releases           = true
  migration_service            = "github"
  migration_service_auth_token = var.github_token
  name                         = "AddressBookCLI"
  private                      = false
  username                     = gitea_user.jack-stockley.username

  depends_on = [gitea_user.jack-stockley]
}

resource "gitea_repository" "address-book-rest" {
  default_branch               = "master"
  description                  = "An Address Book that is stored on a MySQL server and takes full advantage of CRUD! It can be accessed by using a RESTful interface!"
  mirror                       = true
  migration_clone_addresse     = "https://github.com/jnstockley/AddressBookREST.git"
  migration_mirror_interval    = "8h0m0s"
  migration_releases           = true
  migration_service            = "github"
  migration_service_auth_token = var.github_token
  name                         = "AddressBookREST"
  private                      = false
  username                     = gitea_user.jack-stockley.username

  depends_on = [gitea_user.jack-stockley]
}

resource "gitea_repository" "address-book-ui" {
  default_branch               = "master"
  description                  = "An Address Book that is stored on a MySQL server and takes full advantage of CRUD! It can be accessed by using an Angular JS web page!"
  mirror                       = true
  migration_clone_addresse     = "https://github.com/jnstockley/AddressBookUI.git"
  migration_mirror_interval    = "8h0m0s"
  migration_releases           = true
  migration_service            = "github"
  migration_service_auth_token = var.github_token
  name                         = "AddressBookUI"
  private                      = false
  username                     = gitea_user.jack-stockley.username

  depends_on = [gitea_user.jack-stockley]
}

resource "gitea_repository" "address-book-ui-extension" {
  default_branch               = "master"
  description                  = "Takes the Address BookUI website and makes it accessible over a chrome extension"
  mirror                       = true
  migration_clone_addresse     = "https://github.com/jnstockley/AddressBookUIExtension.git"
  migration_mirror_interval    = "8h0m0s"
  migration_releases           = true
  migration_service            = "github"
  migration_service_auth_token = var.github_token
  name                         = "AddressBookUIExtension"
  private                      = false
  username                     = gitea_user.jack-stockley.username

  depends_on = [gitea_user.jack-stockley]
}

resource "gitea_repository" "airflow" {
  default_branch               = "main"
  description                  = null
  mirror                       = true
  migration_clone_addresse     = "https://github.com/jnstockley/airflow.git"
  migration_mirror_interval    = "8h0m0s"
  migration_releases           = true
  migration_service            = "github"
  migration_service_auth_token = var.github_token
  name                         = "airflow"
  private                      = false
  username                     = gitea_user.jack-stockley.username

  depends_on = [gitea_user.jack-stockley]
}

resource "gitea_repository" "api" {
  default_branch               = "main"
  description                  = "Custom API written in Python using FastAPI"
  mirror                       = true
  migration_clone_addresse     = "https://github.com/jnstockley/api.git"
  migration_mirror_interval    = "8h0m0s"
  migration_releases           = true
  migration_service            = "github"
  migration_service_auth_token = var.github_token
  name                         = "api"
  private                      = false
  username                     = gitea_user.jack-stockley.username

  depends_on = [gitea_user.jack-stockley]
}

resource "gitea_repository" "App4App2Grad" {
  default_branch               = "main"
  description                  = null
  mirror                       = true
  migration_clone_addresse     = "https://github.com/jnstockley/App4App2Grad.git"
  migration_mirror_interval    = "8h0m0s"
  migration_releases           = true
  migration_service            = "github"
  migration_service_auth_token = var.github_token
  name                         = "App4App2Grad"
  private                      = false
  username                     = gitea_user.jack-stockley.username

  depends_on = [gitea_user.jack-stockley]
}

resource "gitea_repository" "AppleTracker" {
  default_branch               = "main"
  description                  = null
  mirror                       = true
  migration_clone_addresse     = "https://github.com/jnstockley/AppleTracker.git"
  migration_mirror_interval    = "8h0m0s"
  migration_releases           = true
  migration_service            = "github"
  migration_service_auth_token = var.github_token
  name                         = "AppleTracker"
  private                      = false
  username                     = gitea_user.jack-stockley.username

  depends_on = [gitea_user.jack-stockley]
}

resource "gitea_repository" "beszel" {
  default_branch               = "main"
  description                  = null
  mirror                       = true
  migration_clone_addresse     = "https://github.com/jnstockley/beszel.git"
  migration_mirror_interval    = "8h0m0s"
  migration_releases           = true
  migration_service            = "github"
  migration_service_auth_token = var.github_token
  name                         = "beszel"
  private                      = false
  username                     = gitea_user.jack-stockley.username

  depends_on = [gitea_user.jack-stockley]
}

resource "gitea_repository" "bsn" {
  default_branch               = "main"
  description                  = "Python app to send notifications with lower latency from social networks like YouTube and Twitch"
  mirror                       = true
  migration_clone_addresse     = "https://github.com/jnstockley/bsn.git"
  migration_mirror_interval    = "8h0m0s"
  migration_releases           = true
  migration_service            = "github"
  migration_service_auth_token = var.github_token
  name                         = "bsn"
  private                      = false
  username                     = gitea_user.jack-stockley.username

  depends_on = [gitea_user.jack-stockley]
}

resource "gitea_repository" "bttn" {
  default_branch               = "main"
  description                  = "The future of this project has moved to the BSN repo"
  mirror                       = true
  migration_clone_addresse     = "https://github.com/jnstockley/BTTN.git"
  migration_mirror_interval    = "8h0m0s"
  migration_releases           = true
  migration_service            = "github"
  migration_service_auth_token = var.github_token
  name                         = "BTTN"
  private                      = false
  username                     = gitea_user.jack-stockley.username

  depends_on = [gitea_user.jack-stockley]
}

resource "gitea_repository" "canvas-scripts" {
  default_branch               = "main"
  description                  = null
  mirror                       = true
  migration_clone_addresse     = "https://github.com/jnstockley/CanvasScripts.git"
  migration_mirror_interval    = "8h0m0s"
  migration_releases           = true
  migration_service            = "github"
  migration_service_auth_token = var.github_token
  name                         = "CanvasScripts"
  private                      = true
  username                     = gitea_user.jack-stockley.username

  depends_on = [gitea_user.jack-stockley]
}

resource "gitea_repository" "ece-scholarships" {
  default_branch               = "main"
  description                  = null
  mirror                       = true
  migration_clone_addresse     = "https://github.com/jnstockley/ECE-Scholarships.git"
  migration_mirror_interval    = "8h0m0s"
  migration_releases           = true
  migration_service            = "github"
  migration_service_auth_token = var.github_token
  name                         = "ECE-Scholarships"
  private                      = false
  username                     = gitea_user.jack-stockley.username

  depends_on = [gitea_user.jack-stockley]
}

resource "gitea_repository" "email-to-calendar" {
  default_branch               = "main"
  description                  = "Takes emails from an IMAP server, parses the body, and creates event(s) in a CalDAV calendar"
  mirror                       = true
  migration_clone_addresse     = "https://github.com/jnstockley/email-to-calendar.git"
  migration_mirror_interval    = "8h0m0s"
  migration_releases           = true
  migration_service            = "github"
  migration_service_auth_token = var.github_token
  name                         = "email-to-calendar"
  private                      = false
  username                     = gitea_user.jack-stockley.username

  depends_on = [gitea_user.jack-stockley]
}

resource "gitea_repository" "gh-action-starter" {
  default_branch               = "main"
  description                  = null
  mirror                       = true
  migration_clone_addresse     = "https://github.com/jnstockley/gh-action-starter.git"
  migration_mirror_interval    = "8h0m0s"
  migration_releases           = true
  migration_service            = "github"
  migration_service_auth_token = var.github_token
  name                         = "gh-action-starter"
  private                      = false
  username                     = gitea_user.jack-stockley.username

  depends_on = [gitea_user.jack-stockley]
}

resource "gitea_repository" "gh-ssh-action" {
  default_branch               = "main"
  description                  = null
  mirror                       = true
  migration_clone_addresse     = "https://github.com/jnstockley/gh-ssh-action.git"
  migration_mirror_interval    = "8h0m0s"
  migration_releases           = true
  migration_service            = "github"
  migration_service_auth_token = var.github_token
  name                         = "gh-ssh-action"
  private                      = false
  username                     = gitea_user.jack-stockley.username

  depends_on = [gitea_user.jack-stockley]
}

resource "gitea_repository" "govee-cloud" {
  default_branch               = "main"
  description                  = "Govee Cloud API"
  mirror                       = true
  migration_clone_addresse     = "https://github.com/jnstockley/govee-cloud.git"
  migration_mirror_interval    = "8h0m0s"
  migration_releases           = true
  migration_service            = "github"
  migration_service_auth_token = var.github_token
  name                         = "govee-cloud"
  private                      = false
  username                     = gitea_user.jack-stockley.username

  depends_on = [gitea_user.jack-stockley]
}

resource "gitea_repository" "govee-hassio" {
  default_branch               = "main"
  description                  = "Govee Integration for Home Assistant"
  mirror                       = true
  migration_clone_addresse     = "https://github.com/jnstockley/Govee-Hassio.git"
  migration_mirror_interval    = "8h0m0s"
  migration_releases           = true
  migration_service            = "github"
  migration_service_auth_token = var.github_token
  name                         = "Govee-Hassio"
  private                      = false
  username                     = gitea_user.jack-stockley.username

  depends_on = [gitea_user.jack-stockley]
}

resource "gitea_repository" "govee-hassio-v2" {
  default_branch               = "main"
  description                  = null
  mirror                       = true
  migration_clone_addresse     = "https://github.com/jnstockley/Govee-Hassio-V2.git"
  migration_mirror_interval    = "8h0m0s"
  migration_releases           = true
  migration_service            = "github"
  migration_service_auth_token = var.github_token
  name                         = "Govee-Hassio-V2"
  private                      = false
  username                     = gitea_user.jack-stockley.username

  depends_on = [gitea_user.jack-stockley]
}

resource "gitea_repository" "hassio-addons" {
  default_branch               = "main"
  description                  = null
  mirror                       = true
  migration_clone_addresse     = "https://github.com/jnstockley/Hassio-Addons.git"
  migration_mirror_interval    = "8h0m0s"
  migration_releases           = true
  migration_service            = "github"
  migration_service_auth_token = var.github_token
  name                         = "Hassio-Addons"
  private                      = false
  username                     = gitea_user.jack-stockley.username

  depends_on = [gitea_user.jack-stockley]
}

resource "gitea_repository" "infrastructure" {
  default_branch               = "main"
  description                  = "Contains docker compose files, for infrastructure running on-prem/off-prem"
  mirror                       = true
  migration_clone_addresse     = "https://github.com/jnstockley/infrastructure.git"
  migration_mirror_interval    = "8h0m0s"
  migration_releases           = true
  migration_service            = "github"
  migration_service_auth_token = var.github_token
  name                         = "infrastructure"
  private                      = false
  username                     = gitea_user.jack-stockley.username

  depends_on = [gitea_user.jack-stockley]
}

resource "gitea_repository" "jnstockley-github-io" {
  default_branch               = "main"
  description                  = "Jack Stockley - Computer Science Student at the University of Iowa"
  mirror                       = true
  migration_clone_addresse     = "https://github.com/jnstockley/jnstockley.github.io.git"
  migration_mirror_interval    = "8h0m0s"
  migration_releases           = true
  migration_service            = "github"
  migration_service_auth_token = var.github_token
  name                         = "jnstockley.github.io"
  private                      = false
  username                     = gitea_user.jack-stockley.username

  depends_on = [gitea_user.jack-stockley]
}

resource "gitea_repository" "PiTV" {
  default_branch               = "master"
  description                  = "Turn your Raspberry Pi into a Smart TV!"
  mirror                       = true
  migration_clone_addresse     = "https://github.com/jnstockley/PiTV.git"
  migration_mirror_interval    = "8h0m0s"
  migration_releases           = true
  migration_service            = "github"
  migration_service_auth_token = var.github_token
  name                         = "PiTV"
  private                      = false
  username                     = gitea_user.jack-stockley.username

  depends_on = [gitea_user.jack-stockley]
}

resource "gitea_repository" "poetry" {
  default_branch               = "main"
  description                  = "Bundles Poetry in a convenient Docker image"
  mirror                       = true
  migration_clone_addresse     = "https://github.com/jnstockley/poetry.git"
  migration_mirror_interval    = "8h0m0s"
  migration_releases           = true
  migration_service            = "github"
  migration_service_auth_token = var.github_token
  name                         = "poetry"
  private                      = false
  username                     = gitea_user.jack-stockley.username

  depends_on = [gitea_user.jack-stockley]
}

resource "gitea_repository" "ProductScrapper" {
  default_branch               = "main"
  description                  = null
  mirror                       = true
  migration_clone_addresse     = "https://github.com/jnstockley/ProductScrapper.git"
  migration_mirror_interval    = "8h0m0s"
  migration_releases           = true
  migration_service            = "github"
  migration_service_auth_token = var.github_token
  name                         = "ProductScrapper"
  private                      = false
  username                     = gitea_user.jack-stockley.username

  depends_on = [gitea_user.jack-stockley]
}

resource "gitea_repository" "Project-Syncer" {
  default_branch               = "master"
  description                  = null
  mirror                       = true
  migration_clone_addresse     = "https://github.com/jnstockley/Project-Syncer.git"
  migration_mirror_interval    = "8h0m0s"
  migration_releases           = true
  migration_service            = "github"
  migration_service_auth_token = var.github_token
  name                         = "Project-Syncer"
  private                      = true
  username                     = gitea_user.jack-stockley.username

  depends_on = [gitea_user.jack-stockley]
}

resource "gitea_repository" "python-starter" {
  default_branch               = "main"
  description                  = "A starter project for quickly setting up new Python apps"
  mirror                       = true
  migration_clone_addresse     = "https://github.com/jnstockley/python-starter.git"
  migration_mirror_interval    = "8h0m0s"
  migration_releases           = true
  migration_service            = "github"
  migration_service_auth_token = var.github_token
  name                         = "python-starter"
  private                      = false
  username                     = gitea_user.jack-stockley.username

  depends_on = [gitea_user.jack-stockley]
}

resource "gitea_repository" "r-place-analysis" {
  default_branch               = "main"
  description                  = null
  mirror                       = true
  migration_clone_addresse     = "https://github.com/jnstockley/r-place-analysis.git"
  migration_mirror_interval    = "8h0m0s"
  migration_releases           = true
  migration_service            = "github"
  migration_service_auth_token = var.github_token
  name                         = "r-place-analysis"
  private                      = false
  username                     = gitea_user.jack-stockley.username

  depends_on = [gitea_user.jack-stockley]
}

resource "gitea_repository" "secret-santa" {
  default_branch               = "main"
  description                  = null
  mirror                       = true
  migration_clone_addresse     = "https://github.com/jnstockley/secret-santa.git"
  migration_mirror_interval    = "8h0m0s"
  migration_releases           = true
  migration_service            = "github"
  migration_service_auth_token = var.github_token
  name                         = "secret-santa"
  private                      = false
  username                     = gitea_user.jack-stockley.username

  depends_on = [gitea_user.jack-stockley]
}

resource "gitea_repository" "sickoBambaMode" {
  default_branch               = "master"
  description                  = null
  mirror                       = true
  migration_clone_addresse     = "https://github.com/jnstockley/sickoBambaMode.git"
  migration_mirror_interval    = "8h0m0s"
  migration_releases           = true
  migration_service            = "github"
  migration_service_auth_token = var.github_token
  name                         = "sickoBambaMode"
  private                      = false
  username                     = gitea_user.jack-stockley.username

  depends_on = [gitea_user.jack-stockley]
}

resource "gitea_repository" "Vaccine-Checker" {
  default_branch               = "main"
  description                  = "A simple java program that uses web scraping technology to determine if a vaccine is available in your location and sends you an email."
  mirror                       = true
  migration_clone_addresse     = "https://github.com/jnstockley/Vaccine-Checker.git"
  migration_mirror_interval    = "8h0m0s"
  migration_releases           = true
  migration_service            = "github"
  migration_service_auth_token = var.github_token
  name                         = "Vaccine-Checker"
  private                      = false
  username                     = gitea_user.jack-stockley.username

  depends_on = [gitea_user.jack-stockley]
}

resource "gitea_repository" "web-minning-hw2" {
  default_branch               = "main"
  description                  = null
  mirror                       = true
  migration_clone_addresse     = "https://github.com/jnstockley/web-minning-hw2.git"
  migration_mirror_interval    = "8h0m0s"
  migration_releases           = true
  migration_service            = "github"
  migration_service_auth_token = var.github_token
  name                         = "web-minning-hw2"
  private                      = true
  username                     = gitea_user.jack-stockley.username

  depends_on = [gitea_user.jack-stockley]
}

resource "gitea_repository" "web-scraper" {
  default_branch               = "main"
  description                  = "Customizable Web Scrapper to get alerts when criteria is met on web sites."
  mirror                       = true
  migration_clone_addresse     = "https://github.com/jnstockley/web-scraper.git"
  migration_mirror_interval    = "8h0m0s"
  migration_releases           = true
  migration_service            = "github"
  migration_service_auth_token = var.github_token
  name                         = "web-scraper"
  private                      = false
  username                     = gitea_user.jack-stockley.username

  depends_on = [gitea_user.jack-stockley]
}

resource "gitea_repository" "jnstockley_hawkai_3xx" {
  default_branch               = "main"
  description                  = null
  mirror                       = true
  migration_clone_addresse     = "https://research-git.uiowa.edu/hawkai/jnstockley_hawkai_3xx.git"
  migration_mirror_interval    = "8h0m0s"
  migration_releases           = true
  migration_service            = "gitlab"
  migration_service_auth_token = var.research_git_token
  name                         = "jnstockley_hawkai_3xx"
  private                      = true
  username                     = gitea_user.jack-stockley.username

  depends_on = [gitea_user.jack-stockley]
}

resource "gitea_repository" "terraform" {
  default_branch               = "main"
  description                  = null
  mirror                       = true
  migration_clone_addresse     = "https://gitlab.com/jnstockley/terraform.git"
  migration_mirror_interval    = "8h0m0s"
  migration_releases           = true
  migration_service            = "gitlab"
  migration_service_auth_token = var.gitlab_access_token
  name                         = "terraform"
  private                      = true
  username                     = gitea_user.jack-stockley.username

  depends_on = [gitea_user.jack-stockley]
}
