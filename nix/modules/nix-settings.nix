_:
{
  # If you installed Nix with the Determinate Systems installer (recommended,
  # see README "Prerequisites"), Determinate's own daemon manages
  # /etc/nix/nix.conf and experimental features. Leave this OFF in that case
  # or the two will fight over the same file.
  #
  # If you installed Nix a different way (the official nixos.org installer,
  # Lix, etc.), flip this to `true` so nix-darwin manages nix.conf,
  # experimental-features, and garbage-collection settings for you.
  nix.enable = false;

  # Apple Silicon by default. Intel Macs should set this to "x86_64-darwin"
  # in that host's own hosts/<name>/default.nix instead (system stanza),
  # not here, since this file is shared by every host.
  nixpkgs.hostPlatform = "aarch64-darwin";
}
