{ ... }:
{
  # ---- System preferences -------------------------------------------------
  # Only a subset of System Settings is exposed this way — see
  # docs/SYSTEM_SETTINGS.md for the full list of what's covered, the
  # CustomUserPreferences escape hatch for anything that isn't, and what's
  # not scriptable at all.
  system.defaults = {
    dock = {
      autohide = false;
      show-recents = false;
      mru-spaces = false;
    };

    SoftwareUpdate = {
      AutomaticallyInstallMacOSUpdates=true;
    };

    loginwindow = {
        autoLoginUser = "jackstockley";
        DisableConsoleAccess = true;
        GuestEnabled = false;
    };

    finder = {
      AppleShowAllExtensions = true;
      FXPreferredViewStyle = "Nlsv"; # list view
      ShowPathbar = true;
    };

    NSGlobalDomain = {
      AppleShowAllExtensions = true;
      AppleInterfaceStyle = "Dark";
      AppleShowAllFiles = true;
      NSDocumentSaveNewDocumentsToCloud = false;
    };

    screensaver.askForPasswordDelay = 0;

    WindowManager.StandardHideWidgets = true;

    power.sleep.harddisk = "never";
    power.sleep.display = "never";

    # Uncomment on a real headless box — skips the "are you sure" dialog
    # when a script triggers a restart/shutdown.
    # loginwindow.LoginwindowText = "Managed by nix-darwin — see hosts/";
  };

  # ---- Power management -----------------------------------------------------
  # `pmset` isn't exposed via `system.defaults`, so it's set through an
  # activation script instead. Runs on every `darwin-rebuild switch`, but
  # `pmset` itself is idempotent (just re-applies the same setting).
  #system.activationScripts.postActivation.text = ''
  #  # Disable system sleep when plugged into AC power (-c)
  #  sudo pmset -c sleep 0
  #'';

  # ---- Remote access (needed once this Mac has no keyboard/monitor) -------
  # Confirm the exact option name for the nix-darwin revision this flake is
  # pinned to before relying on it:
  #   https://search.nixos.org/search?channel=unstable&query=openssh&flake=nix-darwin
  # As a fallback you can always do this once by hand instead:
  #   sudo systemsetup -setremotelogin on
  services.openssh.enable = true;

  # ---- Bookkeeping ----------------------------------------------------------
  # This tracks the nix-darwin schema version your config was FIRST written
  # against, not the current one. Do not bump it after initial activation —
  # see README "Known limitations" for why.
  system.stateVersion = 5;
}
