{ pkgs, ... }:
{
  # Packages installed directly from nixpkgs — these get the full benefit of
  # this whole setup: pinned by flake.lock, identical on every rebuild,
  # instantly rollback-able with everything else via
  # `darwin-rebuild switch --rollback`.
  #
  # See docs/PACKAGES.md for *when* to put something here vs. in
  # modules/homebrew.nix — short version: CLI/dev tooling goes here, GUI
  # apps go in homebrew.nix as casks.
  #
  # Search before adding: https://search.nixos.org/packages?channel=unstable
  # or from a terminal that already has Nix: `nix search nixpkgs <name>`
  environment.systemPackages = with pkgs; [
    docker
    fastfetch
    ollama
    gh
    git
  ];
}
