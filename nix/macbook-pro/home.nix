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

  home.homebrew = {
    enable = true;
    brews = [
      "nvm"
      "mas"
    ];
    casks = [
      "balenaetcher"
      "malwarebytes"
      "steam"
      "visual-studio-code"
      "vnc-server"
      "docker"
      "roblox"
      "termius"
      "minecraft"
      "jetbrains-toolbox"
      "firefox"
      "nextcloud"
      "rustdesk"
      "ghostty"
    ];
    #masApps = {
    #  "Bitwarden" = 1352778147;
    #  "Hidden Bar" = 1452453066;
    #  "Windows App" = 1295203466;
    #  "Wireguard" = 1441195209;
    #  "Excel" = 62058435;
    #  "Powerpoint" = 462062816;
    #  "Word" = 462054704;
    #  "OneDrive" = 823766827;
    #};
    onActivation = {
      autoUpdate = true;
      cleanup = "uninstall";
      upgrade = true;
    };
  };

  targets.darwin = {
    defaults = import ./settings.nix { inherit config pkgs; };
  };

  home.stateVersion = "24.11";

  programs = {
    zsh = import ./zsh.nix { inherit config pkgs lib; };
  };
}
