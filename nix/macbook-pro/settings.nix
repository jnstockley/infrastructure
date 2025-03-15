{
  config,
  pkgs,
  ...
}:
{
    NSGlobalDomain = {
        AppleShowAllExtensions = true;
        NSTableViewDefaultSizeMode = 2;
        AppleInterfaceStyle = "Dark";
        AppleInterfaceStyleSwitchesAutomatically = false;
        NSDocumentSaveNewDocumentsToCloud = false;
    };
    finder = {
        FXRemoveOldTrashItems = true;
        NewWindowTarget = "Home";
        ShowHardDrivesOnDesktop = true;
        ShowExternalHardDrivesOnDesktop = true;
        ShowPathbar = true;
        ShowStatusBar = true;
        _FXShowPosixPathInTitle = true;
        FXPreferredViewStyle = "Nlsv";
        _FXSortFoldersFirst = true;
        FXDefaultSearchScope = "SCcf";
    };
    WindowManager.EnableStandardClickToShowDesktop = false;
    CustomUserPreferences = {
      NSGlobalDomain = {
        # Add a context menu item for showing the Web Inspector in web views
        WebKitDeveloperExtras = true;
      };
      "com.apple.finder" = {
         ShowRecentTags = false;
      };
      "com.apple.symbolichotkeys" = {
        AppleSymbolicHotKeys = {
          # Disable 'Cmd + Space' for Spotlight Search
          "64" = {
            enabled = false;
          };
          # Disable 'Cmd + Alt + Space' for Finder search window
          "65" = {
            enabled = false;
          };
        };
      };
      "com.apple.SoftwareUpdate" = {
        AutomaticCheckEnabled = true;
        # Check for software updates daily, not just once per week
        ScheduleFrequency = 1;
        # Download newly available updates in background
        AutomaticDownload = 1;
        # Install System data files & security updates
        CriticalUpdateInstall = 1;
      };
      # Turn on app auto-update
      "com.apple.commerce".AutoUpdate = true;
    };
}
