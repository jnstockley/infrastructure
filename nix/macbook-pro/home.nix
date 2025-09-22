{
  config,
  pkgs,
  lib,
  ...
}:
let
  inherit (config.lib.file) mkOutOfStoreSymlink;
in rec
{
  programs.home-manager.enable = true;

  home.username = "jackstockley";
  home.homeDirectory = "/Users/${home.username}";
  home.enableNixpkgsReleaseCheck = false;
  xdg.enable = true;

  targets.darwin = {
    defaults = import ./settings.nix { inherit config pkgs; };
  };

  home.stateVersion = "24.11";

  home.packages = with pkgs; [
    mysides
  ];

  home.activation.applications.text =  ''
      # Clear all Finder favorites
      ${pkgs.mysides}/bin/mysides remove all || true

      # Add Finder favorites
      ${pkgs.mysides}/bin/mysides add Applications file:///Applications/
      ${pkgs.mysides}/bin/mysides add Downloads file:///$HOME/Downloads/
      ${pkgs.mysides}/bin/mysides add Documents file:///$HOME/Documents/
      ${pkgs.mysides}/bin/mysides add Home file:///$HOME/

      if [ ! -d "$HOME/Nextcloud" ]; then
        mkdir -p "$HOME/Nextcloud"
        chown "$(id -un)":staff "$HOME/Nextcloud"
        chmod 700 "$HOME/Nextcloud"
      fi

      ${pkgs.mysides}/bin/mysides add Nextcloud "file:///$HOME/Nextcloud"

      killall Finder || true

      # Login Items (runs as the user; no sudo)
      /usr/bin/osascript -e 'tell application "System Events" to make login item at end with properties {path:"/Applications/Nextcloud.app", hidden:true}'
      /usr/bin/osascript -e 'tell application "System Events" to make login item at end with properties {path:"/Applications/JetBrains Toolbox.app", hidden:true}'
      /usr/bin/osascript -e 'tell application "System Events" to make login item at end with properties {path:"/Applications/Steam.app", hidden:true}'
    '';

  programs = {
    zsh = import ./zsh.nix { inherit config pkgs lib; };
  };
}
