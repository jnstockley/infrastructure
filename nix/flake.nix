{
  description = "Declarative macOS configuration (nix-darwin only, no home-manager)";

  inputs = {
    # nixpkgs-unstable tracks the latest package versions. If you'd rather
    # trade freshness for stability, point this at a release branch instead,
    # e.g. "github:NixOS/nixpkgs/nixos-25.05".
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    nix-darwin = {
      url = "github:LnL7/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Wires nixfmt (the official formatter) + statix + deadnix (linters)
    # together behind one `nix fmt` / `nix flake check` interface.
    # See treefmt.nix and docs/LINTING.md.
    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nix-darwin, treefmt-nix, ... }:
    let
      # Shared "recipe" for turning a hostname into a full darwin system.
      # Every Mac you manage gets one line below — see hosts/<name>/default.nix
      # for what's actually machine-specific.
      mkHost = { hostname, system ? "aarch64-darwin" }:
        nix-darwin.lib.darwinSystem {
          inherit system;
          specialArgs = { inherit hostname; };
          modules = [
            ./modules/nix-settings.nix
            ./modules/packages.nix
            ./modules/homebrew.nix
            ./modules/system-defaults.nix
            (./hosts + "/${hostname}/default.nix")
          ];
        };

      # Formatting/linting works on any machine you edit this repo from
      # (your Mac, a Linux CI runner, etc.) — not just the darwin hosts
      # above, so it gets its own, broader system list.
      lintSystems = [ "aarch64-darwin" "x86_64-darwin" "aarch64-linux" "x86_64-linux" ];
      forAllSystems = nixpkgs.lib.genAttrs lintSystems;

      treefmtEval = forAllSystems (
        system: treefmt-nix.lib.evalModule nixpkgs.legacyPackages.${system} ./treefmt.nix
      );
    in
    {
      darwinConfigurations = {
        mini = mkHost { hostname = "mini"; };

        # Add another Mac with: scripts/new-host.sh <name>
        # then uncomment/add a line like:
        # macbook = mkHost { hostname = "macbook"; };
        # (add `system = "x86_64-darwin";` here too if it's an Intel Mac)
      };

      # Enables `nix fmt` to auto-format every .nix file (nixfmt, via treefmt).
      formatter = forAllSystems (system: treefmtEval.${system}.config.build.wrapper);

      # Enables `nix flake check` to verify formatting + run statix/deadnix
      # without changing any files — this is what CI runs.
      checks = forAllSystems (system: {
        formatting = treefmtEval.${system}.config.build.check self;
      });
    };
}
