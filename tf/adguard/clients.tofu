# manage a client
resource "adguard_client" "iphone" {
  name = "Jack's iPhone 16 Pro Max"
  ids  = ["jack-iphone-16-pro"]
}

# manage a client
resource "adguard_client" "macbook-pro" {
  name = "Jack's MacBook Pro"
  ids  = ["jack-macbook-pro"]
}

# manage a client
resource "adguard_client" "ipad" {
  name = "Jack's iPad Pro"
  ids  = ["jack-ipad-pro"]
}

# manage a client
resource "adguard_client" "apple-tv" {
  name = "Jack's Apple TV"
  ids  = ["jack-apple-tv"]
}
