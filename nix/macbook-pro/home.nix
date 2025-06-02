{
  config,
  pkgs,
  lib,
  ...
}:
let
  inherit (config.lib.file) mkOutOfStoreSymlink;
in
{
  programs.home-manager.enable = true;

  home.username = "jackstockley";
  home.homeDirectory = "/Users/jackstockley";
  home.enableNixpkgsReleaseCheck = false;
  xdg.enable = true;

  targets.darwin.defaults = {
    settingsFile = import ./settings.nix { inherit config pkgs; };
  };

  home.stateVersion = "24.11";

  programs = {
    zsh = import ./zsh.nix { inherit config pkgs lib; };
  };
}
