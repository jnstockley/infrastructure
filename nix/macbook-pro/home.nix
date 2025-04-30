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


  home.stateVersion = "25.05";

  programs = {
    zsh = import ./zsh.nix { inherit config pkgs lib; };
  };
}
