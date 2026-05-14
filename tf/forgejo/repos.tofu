resource "forgejo_repository" "address-book" {
  default_branch  = "master"
  description     = "The backend for the Address Book REST API. Helps interface between java code and SQL database!"
  mirror          = true
  clone_addr      = "https://github.com/jnstockley/AddressBook.git"
  mirror_interval = "8h0m0s"
  has_releases    = true
  service         = "github"
  auth_token      = var.github_token
  name            = "AddressBook"
  private         = false
  owner           = forgejo_user.jack-stockley.login

  depends_on = [forgejo_user.jack-stockley]
}

resource "forgejo_repository" "address-book-cli" {
  default_branch  = "master"
  description     = "An Address Book that is stored on a MySQL server and takes full advantage of CRUD!"
  mirror          = true
  clone_addr      = "https://github.com/jnstockley/AddressBookCLI.git"
  mirror_interval = "8h0m0s"
  has_releases    = true
  service         = "github"
  auth_token      = var.github_token
  name            = "AddressBookCLI"
  private         = false
  owner           = forgejo_user.jack-stockley.login

  depends_on = [forgejo_user.jack-stockley]
}

resource "forgejo_repository" "address-book-rest" {
  default_branch  = "master"
  description     = "An Address Book that is stored on a MySQL server and takes full advantage of CRUD! It can be accessed by using a RESTful interface!"
  mirror          = true
  clone_addr      = "https://github.com/jnstockley/AddressBookREST.git"
  mirror_interval = "8h0m0s"
  has_releases    = true
  service         = "github"
  auth_token      = var.github_token
  name            = "AddressBookREST"
  private         = false
  owner           = forgejo_user.jack-stockley.login

  depends_on = [forgejo_user.jack-stockley]
}

resource "forgejo_repository" "address-book-ui" {
  default_branch  = "master"
  description     = "An Address Book that is stored on a MySQL server and takes full advantage of CRUD! It can be accessed by using an Angular JS web page!"
  mirror          = true
  clone_addr      = "https://github.com/jnstockley/AddressBookUI.git"
  mirror_interval = "8h0m0s"
  has_releases    = true
  service         = "github"
  auth_token      = var.github_token
  name            = "AddressBookUI"
  private         = false
  owner           = forgejo_user.jack-stockley.login

  depends_on = [forgejo_user.jack-stockley]
}

resource "forgejo_repository" "address-book-ui-extension" {
  default_branch  = "master"
  description     = "Takes the Address BookUI website and makes it accessible over a chrome extension"
  mirror          = true
  clone_addr      = "https://github.com/jnstockley/AddressBookUIExtension.git"
  mirror_interval = "8h0m0s"
  has_releases    = true
  service         = "github"
  auth_token      = var.github_token
  name            = "AddressBookUIExtension"
  private         = false
  owner           = forgejo_user.jack-stockley.login

  depends_on = [forgejo_user.jack-stockley]
}

resource "forgejo_repository" "airflow" {
  default_branch  = "main"
  description     = null
  mirror          = true
  clone_addr      = "https://github.com/jnstockley/airflow.git"
  mirror_interval = "8h0m0s"
  has_releases    = true
  service         = "github"
  auth_token      = var.github_token
  name            = "airflow"
  private         = false
  owner           = forgejo_user.jack-stockley.login

  depends_on = [forgejo_user.jack-stockley]
}

resource "forgejo_repository" "api" {
  default_branch  = "main"
  description     = "Custom API written in Python using FastAPI"
  mirror          = true
  clone_addr      = "https://github.com/jnstockley/api.git"
  mirror_interval = "8h0m0s"
  has_releases    = true
  service         = "github"
  auth_token      = var.github_token
  name            = "api"
  private         = false
  owner           = forgejo_user.jack-stockley.login

  depends_on = [forgejo_user.jack-stockley]
}

resource "forgejo_repository" "App4App2Grad" {
  default_branch  = "main"
  description     = null
  mirror          = true
  clone_addr      = "https://github.com/jnstockley/App4App2Grad.git"
  mirror_interval = "8h0m0s"
  has_releases    = true
  service         = "github"
  auth_token      = var.github_token
  name            = "App4App2Grad"
  private         = false
  owner           = forgejo_user.jack-stockley.login

  depends_on = [forgejo_user.jack-stockley]
}

resource "forgejo_repository" "AppleTracker" {
  default_branch  = "main"
  description     = null
  mirror          = true
  clone_addr      = "https://github.com/jnstockley/AppleTracker.git"
  mirror_interval = "8h0m0s"
  has_releases    = true
  service         = "github"
  auth_token      = var.github_token
  name            = "AppleTracker"
  private         = false
  owner           = forgejo_user.jack-stockley.login

  depends_on = [forgejo_user.jack-stockley]
}

resource "forgejo_repository" "beszel" {
  default_branch  = "main"
  description     = null
  mirror          = true
  clone_addr      = "https://github.com/jnstockley/beszel.git"
  mirror_interval = "8h0m0s"
  has_releases    = true
  service         = "github"
  auth_token      = var.github_token
  name            = "beszel"
  private         = false
  owner           = forgejo_user.jack-stockley.login

  depends_on = [forgejo_user.jack-stockley]
}

resource "forgejo_repository" "bsn" {
  default_branch  = "main"
  description     = "Python app to send notifications with lower latency from social networks like YouTube and Twitch"
  mirror          = true
  clone_addr      = "https://github.com/jnstockley/bsn.git"
  mirror_interval = "8h0m0s"
  has_releases    = true
  service         = "github"
  auth_token      = var.github_token
  name            = "bsn"
  private         = false
  owner           = forgejo_user.jack-stockley.login

  depends_on = [forgejo_user.jack-stockley]
}

resource "forgejo_repository" "bttn" {
  default_branch  = "main"
  description     = "The future of this project has moved to the BSN repo"
  mirror          = true
  clone_addr      = "https://github.com/jnstockley/BTTN.git"
  mirror_interval = "8h0m0s"
  has_releases    = true
  service         = "github"
  auth_token      = var.github_token
  name            = "BTTN"
  private         = false
  owner           = forgejo_user.jack-stockley.login

  depends_on = [forgejo_user.jack-stockley]
}

resource "forgejo_repository" "canvas-scripts" {
  default_branch  = "main"
  description     = null
  mirror          = true
  clone_addr      = "https://github.com/jnstockley/CanvasScripts.git"
  mirror_interval = "8h0m0s"
  has_releases    = true
  service         = "github"
  auth_token      = var.github_token
  name            = "CanvasScripts"
  private         = true
  owner           = forgejo_user.jack-stockley.login

  depends_on = [forgejo_user.jack-stockley]
}

resource "forgejo_repository" "ece-scholarships" {
  default_branch  = "main"
  description     = null
  mirror          = true
  clone_addr      = "https://github.com/jnstockley/ECE-Scholarships.git"
  mirror_interval = "8h0m0s"
  has_releases    = true
  service         = "github"
  auth_token      = var.github_token
  name            = "ECE-Scholarships"
  private         = false
  owner           = forgejo_user.jack-stockley.login

  depends_on = [forgejo_user.jack-stockley]
}

resource "forgejo_repository" "email-to-calendar" {
  default_branch  = "main"
  description     = "Takes emails from an IMAP server, parses the body, and creates event(s) in a CalDAV calendar"
  mirror          = true
  clone_addr      = "https://github.com/jnstockley/email-to-calendar.git"
  mirror_interval = "8h0m0s"
  has_releases    = true
  service         = "github"
  auth_token      = var.github_token
  name            = "email-to-calendar"
  private         = false
  owner           = forgejo_user.jack-stockley.login

  depends_on = [forgejo_user.jack-stockley]
}

resource "forgejo_repository" "gh-action-starter" {
  default_branch  = "main"
  description     = null
  mirror          = true
  clone_addr      = "https://github.com/jnstockley/gh-action-starter.git"
  mirror_interval = "8h0m0s"
  has_releases    = true
  service         = "github"
  auth_token      = var.github_token
  name            = "gh-action-starter"
  private         = false
  owner           = forgejo_user.jack-stockley.login

  depends_on = [forgejo_user.jack-stockley]
}

resource "forgejo_repository" "gh-ssh-action" {
  default_branch  = "main"
  description     = null
  mirror          = true
  clone_addr      = "https://github.com/jnstockley/gh-ssh-action.git"
  mirror_interval = "8h0m0s"
  has_releases    = true
  service         = "github"
  auth_token      = var.github_token
  name            = "gh-ssh-action"
  private         = false
  owner           = forgejo_user.jack-stockley.login

  depends_on = [forgejo_user.jack-stockley]
}

resource "forgejo_repository" "govee-cloud" {
  default_branch  = "main"
  description     = "Govee Cloud API"
  mirror          = true
  clone_addr      = "https://github.com/jnstockley/govee-cloud.git"
  mirror_interval = "8h0m0s"
  has_releases    = true
  service         = "github"
  auth_token      = var.github_token
  name            = "govee-cloud"
  private         = false
  owner           = forgejo_user.jack-stockley.login

  depends_on = [forgejo_user.jack-stockley]
}

resource "forgejo_repository" "govee-hassio" {
  default_branch  = "main"
  description     = "Govee Integration for Home Assistant"
  mirror          = true
  clone_addr      = "https://github.com/jnstockley/Govee-Hassio.git"
  mirror_interval = "8h0m0s"
  has_releases    = true
  service         = "github"
  auth_token      = var.github_token
  name            = "Govee-Hassio"
  private         = false
  owner           = forgejo_user.jack-stockley.login

  depends_on = [forgejo_user.jack-stockley]
}

resource "forgejo_repository" "govee-hassio-v2" {
  default_branch  = "main"
  description     = null
  mirror          = true
  clone_addr      = "https://github.com/jnstockley/Govee-Hassio-V2.git"
  mirror_interval = "8h0m0s"
  has_releases    = true
  service         = "github"
  auth_token      = var.github_token
  name            = "Govee-Hassio-V2"
  private         = false
  owner           = forgejo_user.jack-stockley.login

  depends_on = [forgejo_user.jack-stockley]
}

resource "forgejo_repository" "hassio-addons" {
  default_branch  = "main"
  description     = null
  mirror          = true
  clone_addr      = "https://github.com/jnstockley/Hassio-Addons.git"
  mirror_interval = "8h0m0s"
  has_releases    = true
  service         = "github"
  auth_token      = var.github_token
  name            = "Hassio-Addons"
  private         = false
  owner           = forgejo_user.jack-stockley.login

  depends_on = [forgejo_user.jack-stockley]
}

resource "forgejo_repository" "infrastructure" {
  default_branch  = "main"
  description     = "Contains docker compose files, for infrastructure running on-prem/off-prem"
  mirror          = true
  clone_addr      = "https://github.com/jnstockley/infrastructure.git"
  mirror_interval = "8h0m0s"
  has_releases    = true
  service         = "github"
  auth_token      = var.github_token
  name            = "infrastructure"
  private         = false
  owner           = forgejo_user.jack-stockley.login

  depends_on = [forgejo_user.jack-stockley]
}

resource "forgejo_repository" "jnstockley-github-io" {
  default_branch  = "main"
  description     = "Jack Stockley - Computer Science Student at the University of Iowa"
  mirror          = true
  clone_addr      = "https://github.com/jnstockley/jnstockley.github.io.git"
  mirror_interval = "8h0m0s"
  has_releases    = true
  service         = "github"
  auth_token      = var.github_token
  name            = "jnstockley.github.io"
  private         = false
  owner           = forgejo_user.jack-stockley.login

  depends_on = [forgejo_user.jack-stockley]
}

resource "forgejo_repository" "PiTV" {
  default_branch  = "master"
  description     = "Turn your Raspberry Pi into a Smart TV!"
  mirror          = true
  clone_addr      = "https://github.com/jnstockley/PiTV.git"
  mirror_interval = "8h0m0s"
  has_releases    = true
  service         = "github"
  auth_token      = var.github_token
  name            = "PiTV"
  private         = false
  owner           = forgejo_user.jack-stockley.login

  depends_on = [forgejo_user.jack-stockley]
}

resource "forgejo_repository" "poetry" {
  default_branch  = "main"
  description     = "Bundles Poetry in a convenient Docker image"
  mirror          = true
  clone_addr      = "https://github.com/jnstockley/poetry.git"
  mirror_interval = "8h0m0s"
  has_releases    = true
  service         = "github"
  auth_token      = var.github_token
  name            = "poetry"
  private         = false
  owner           = forgejo_user.jack-stockley.login

  depends_on = [forgejo_user.jack-stockley]
}

resource "forgejo_repository" "ProductScrapper" {
  default_branch  = "main"
  description     = null
  mirror          = true
  clone_addr      = "https://github.com/jnstockley/ProductScrapper.git"
  mirror_interval = "8h0m0s"
  has_releases    = true
  service         = "github"
  auth_token      = var.github_token
  name            = "ProductScrapper"
  private         = false
  owner           = forgejo_user.jack-stockley.login

  depends_on = [forgejo_user.jack-stockley]
}

resource "forgejo_repository" "Project-Syncer" {
  default_branch  = "master"
  description     = null
  mirror          = true
  clone_addr      = "https://github.com/jnstockley/Project-Syncer.git"
  mirror_interval = "8h0m0s"
  has_releases    = true
  service         = "github"
  auth_token      = var.github_token
  name            = "Project-Syncer"
  private         = true
  owner           = forgejo_user.jack-stockley.login

  depends_on = [forgejo_user.jack-stockley]
}

resource "forgejo_repository" "python-starter" {
  default_branch  = "main"
  description     = "A starter project for quickly setting up new Python apps"
  mirror          = true
  clone_addr      = "https://github.com/jnstockley/python-starter.git"
  mirror_interval = "8h0m0s"
  has_releases    = true
  service         = "github"
  auth_token      = var.github_token
  name            = "python-starter"
  private         = false
  owner           = forgejo_user.jack-stockley.login

  depends_on = [forgejo_user.jack-stockley]
}

resource "forgejo_repository" "r-place-analysis" {
  default_branch  = "main"
  description     = null
  mirror          = true
  clone_addr      = "https://github.com/jnstockley/r-place-analysis.git"
  mirror_interval = "8h0m0s"
  has_releases    = true
  service         = "github"
  auth_token      = var.github_token
  name            = "r-place-analysis"
  private         = false
  owner           = forgejo_user.jack-stockley.login

  depends_on = [forgejo_user.jack-stockley]
}

resource "forgejo_repository" "secret-santa" {
  default_branch  = "main"
  description     = null
  mirror          = true
  clone_addr      = "https://github.com/jnstockley/secret-santa.git"
  mirror_interval = "8h0m0s"
  has_releases    = true
  service         = "github"
  auth_token      = var.github_token
  name            = "secret-santa"
  private         = false
  owner           = forgejo_user.jack-stockley.login

  depends_on = [forgejo_user.jack-stockley]
}

resource "forgejo_repository" "sickoBambaMode" {
  default_branch  = "master"
  description     = null
  mirror          = true
  clone_addr      = "https://github.com/jnstockley/sickoBambaMode.git"
  mirror_interval = "8h0m0s"
  has_releases    = true
  service         = "github"
  auth_token      = var.github_token
  name            = "sickoBambaMode"
  private         = false
  owner           = forgejo_user.jack-stockley.login

  depends_on = [forgejo_user.jack-stockley]
}

resource "forgejo_repository" "Vaccine-Checker" {
  default_branch  = "main"
  description     = "A simple java program that uses web scraping technology to determine if a vaccine is available in your location and sends you an email."
  mirror          = true
  clone_addr      = "https://github.com/jnstockley/Vaccine-Checker.git"
  mirror_interval = "8h0m0s"
  has_releases    = true
  service         = "github"
  auth_token      = var.github_token
  name            = "Vaccine-Checker"
  private         = false
  owner           = forgejo_user.jack-stockley.login

  depends_on = [forgejo_user.jack-stockley]
}

resource "forgejo_repository" "web-minning-hw2" {
  default_branch  = "main"
  description     = null
  mirror          = true
  clone_addr      = "https://github.com/jnstockley/web-minning-hw2.git"
  mirror_interval = "8h0m0s"
  has_releases    = true
  service         = "github"
  auth_token      = var.github_token
  name            = "web-minning-hw2"
  private         = true
  owner           = forgejo_user.jack-stockley.login

  depends_on = [forgejo_user.jack-stockley]
}

resource "forgejo_repository" "web-scraper" {
  default_branch  = "main"
  description     = "Customizable Web Scrapper to get alerts when criteria is met on web sites."
  mirror          = true
  clone_addr      = "https://github.com/jnstockley/web-scraper.git"
  mirror_interval = "8h0m0s"
  has_releases    = true
  service         = "github"
  auth_token      = var.github_token
  name            = "web-scraper"
  private         = false
  owner           = forgejo_user.jack-stockley.login

  depends_on = [forgejo_user.jack-stockley]
}

resource "forgejo_repository" "jnstockley_hawkai_3xx" {
  default_branch  = "main"
  description     = null
  mirror          = true
  clone_addr      = "https://research-git.uiowa.edu/hawkai/jnstockley_hawkai_3xx.git"
  mirror_interval = "8h0m0s"
  has_releases    = true
  service         = "gitlab"
  auth_token      = var.research_git_token
  name            = "jnstockley_hawkai_3xx"
  private         = true
  owner           = forgejo_user.jack-stockley.login

  depends_on = [forgejo_user.jack-stockley]
}

