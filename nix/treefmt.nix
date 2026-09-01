# Configuration for treefmt-nix (wired into flake.nix's `formatter` and
# `checks` outputs). Run `nix fmt` to auto-format, `nix flake check` (or
# scripts/lint.sh) to check without modifying anything — see
# docs/LINTING.md.
_: {
  projectRootFile = "flake.nix";

  programs = {
    # The official Nix formatter (RFC 166). Auto-formats every .nix file
    # to one consistent style — no configuration knobs by design.
    nixfmt.enable = true;

    # Linter for common Nix anti-patterns (e.g. `with pkgs; with lib;`
    # ambiguity, redundant `rec`, `let x = x; in x`-style mistakes).
    statix.enable = true;

    # Finds genuinely unused code: unreferenced `let` bindings, unused
    # function arguments, dead attrset keys.
    deadnix.enable = true;
  };
}
