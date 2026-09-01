_: {
  # nix-darwin doesn't install GUI apps itself (the Nix store's immutability
  # doesn't play well with apps that expect to self-update or be dragged to
  # /Applications). Instead it drives Homebrew declaratively: this file is
  # the single source of truth, and `brew` becomes an implementation detail.
  homebrew = {
    enable = true;

    onActivation = {
      autoUpdate = true; # `brew update` before installing
      upgrade = true; # `brew upgrade` anything already installed
      # "zap"  = uninstall anything present on the Mac but NOT listed below
      #          (true declarative state — a laptop that drifts gets pulled
      #          back in line on the next `darwin-rebuild switch`).
      # "uninstall" = same, but leaves app data/caches behind (gentler).
      # "none" = never remove anything automatically (safest while you're
      #          still building out this list — flip to "zap" once it's
      #          complete and you trust it).
      cleanup = "zap";
    };

    taps = [
      # "homebrew/services"
    ];

    # CLI tools you want installed via Homebrew specifically (things not
    # in nixpkgs, or that need to be a "real" macOS binary rather than a
    # Nix store path — e.g. anything that needs to see /Applications).
    brews = [
      "mas" # Mac App Store CLI — required for masApps below
    ];

    # GUI applications (Homebrew Casks).
    casks = [
      "vnc-server"
    ];

    # Mac App Store apps, by numeric ID (find with: mas search "<name>").
    # Requires you to be signed into the App Store GUI at least once —
    # see README "Known limitations".
    masApps = {
      # "Xcode" = 497799835;
    };
  };
}
