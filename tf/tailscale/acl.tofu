resource "tailscale_acl" "as_json" {
  acl = jsonencode({
    grants = [
      {
        "src" : ["jack@jstockley.com"],
        "dst" : ["*"],
        "ip" : ["*"]
      },
      {
        "src" : ["tag:arcane-agent"],
        "dst" : ["tag:arcane-manager"],
        "ip" : ["tcp:3552"],
      },
    ],
    "tagOwners" : {
      "tag:docker" : ["jack@jstockley.com"],
      "tag:racknerd" : ["jack@jstockley.com"],
      "tag:photo-server" : ["jack@jstockley.com"],
      "tag:arcane-agent" : ["jack@jstockley.com"],
      "tag:arcane-manager" : ["jack@jstockley.com"],
    },
  })
}
