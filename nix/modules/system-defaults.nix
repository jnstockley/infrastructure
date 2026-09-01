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
      AutomaticallyInstallMacOSUpdates = true;
    };

    loginwindow = {
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

    # Uncomment on a real headless box — skips the "are you sure" dialog
    # when a script triggers a restart/shutdown.
    # loginwindow.LoginwindowText = "Managed by nix-darwin — see hosts/";
  };

  # ---- Power management -----------------------------------------------------
  # Disk/display/system sleep aren't `defaults` plist keys, so they can't go
  # under `system.defaults` above — they're only settable via `pmset`. This
  # runs on every `darwin-rebuild switch`; `pmset` itself is idempotent (just
  # re-applies the same values), and it runs as root already during
  # activation, so no `sudo` is needed here.
  system.activationScripts.postActivation.text = ''
    # -c = settings while on AC power. 0 == never sleep.
    pmset -c sleep 0 disksleep 0 displaysleep 0
    launchctl load -w /System/Library/LaunchDaemons/com.apple.screensharing.plist 2>/dev/null || true
  '';

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
