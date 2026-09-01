_:
{
  # ---- Identity -------------------------------------------------------------
  networking.hostName = "mini";
  networking.computerName = "Mac Mini";
  networking.localHostName = "mini";

  # nix-darwin needs to know which local account it's managing.
  # Replace with your actual short username (run `whoami` to check).
  system.primaryUser = "jackstockley";

  users.users.jackstockley = {
    home = "/Users/jackstockley";
  };

  # ---- Host-specific overrides ----------------------------------------------
  # Anything here overrides modules/*.nix for this Mac only. Example:
  #
  # homebrew.casks = [
  #   "iterm2"
  #   "rectangle"
  #   "orbstack"
  # ];
  #
  # system.defaults.dock.autohide = false; # override the shared default
}
