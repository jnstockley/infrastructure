{
  description = "MacBook Pro nix-darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";

    # Home Manager
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    inputs@{
      self,
      nix-darwin,
      nixpkgs,
      nix-homebrew,
      home-manager,
    }:
    let
      username = "jackstockley";
      configuration =
        { pkgs, config, ... }:
        {
          nixpkgs.config.allowUnfree = true;

          users.users.USER.shell = pkgs.zsh;

          environment.systemPackages = [
            pkgs.vim
            pkgs.gh
            pkgs.raycast
            pkgs.fastfetch
            pkgs.jq
            pkgs.pyenv
            pkgs.shellcheck
            pkgs.shfmt
            pkgs.uv
            pkgs.yamllint
            pkgs.discord
            pkgs.postman
            pkgs.tailscale
            pkgs.utm
            pkgs.realvnc-vnc-viewer
            pkgs.mkalias
            pkgs.nerd-fonts.jetbrains-mono
            pkgs.nixfmt-rfc-style
            pkgs.oh-my-zsh
            # Pyenv dependencies
            pkgs.openssl
            pkgs.readline
            pkgs.xz
            pkgs.sqlite
            pkgs.zlib
            pkgs.libb2
            pkgs.tcl
            pkgs.tclPackages.tclx
          ];

          users.users.${username} = {
            name = username;
            home = "/Users/${username}";
          };

          homebrew = {
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
              "mysides"
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

          system.activationScripts.postUserActivation.text = ''
            # Following line should allow us to avoid a logout/login cycle when changing settings
            /System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u
          '';

          system.defaults = import ./settings.nix { inherit config pkgs; };

          system.activationScripts.applications.text =
            #let
            #  env = pkgs.buildEnv {
            #    name = "system-applications";
            #    paths = config.environment.systemPackages;
            #    pathsToLink = "/Applications";
            #  };
            #in
            #pkgs.lib.mkForce ''
            #  # Set up applications.
            #  echo "setting up /Applications..." >&2
            #  rm -rf /Applications/Nix\ Apps
            #  mkdir -p /Applications/Nix\ Apps
            #  find ${env}/Applications -maxdepth 1 -type l -exec readlink '{}' + |
            #  while read -r src; do
            #    app_name=$(basename "$src")
            #    echo "copying $src" >&2
            #    ${pkgs.mkalias}/bin/mkalias "$src" "/Applications/Nix Apps/$app_name"
            #  done
            ''
              # Clear all Finder favorites
              /usr/local/bin/mysides remove all

              # Add Finder favorites
              /usr/local/bin/mysides add Applications file:///Applications/
              /usr/local/bin/mysides add Downloads file:///Users/${username}/Downloads/
              /usr/local/bin/mysides add Documents file:///Users/${username}/Documents/
              /usr/local/bin/mysides add Home file:///Users/${username}/

              if [ ! -d /Users/${username}/Nextcloud ]; then
                  mkdir /Users/${username}/Nextcloud
                  chown ${username}:staff /Users/${username}/Nextcloud
                  chmod 700 /Users/${username}/Nextcloud
              fi

              /usr/local/bin/mysides add Nextcloud file:///Users/${username}/Nextcloud

              killall Finder

              sudo defaults write /Library/Preferences/com.apple.SoftwareUpdate AutomaticallyInstallMacOSUpdates -bool TRUE

              # Login Items
              /usr/bin/osascript -e 'tell application "System Events" to make login item at end with properties {path:"/Applications/Nextcloud.app", hidden:true}'
              /usr/bin/osascript -e 'tell application "System Events" to make login item at end with properties {path:"/Applications/JetBrains Toolbox.app", hidden:true}'
              /usr/bin/osascript -e 'tell application "System Events" to make login item at end with properties {path:"/Applications/Steam.app", hidden:true}'
            '';

          # Necessary for using flakes on this system.
          nix.settings.experimental-features = "nix-command flakes";
          nix.settings.download-buffer-size = 10485760; # 10MB buffer

          # Enable alternative shell support in nix-darwin.
          programs.zsh.enable = true;
          programs.zsh.enableBashCompletion = true;
          programs.zsh.enableCompletion = true;
          programs.zsh.enableFastSyntaxHighlighting = true;

          # Set Git commit hash for darwin-version.
          system.configurationRevision = self.rev or self.dirtyRev or null;

          # Used for backwards compatibility, please read the changelog before changing.
          # $ darwin-rebuild changelog
          system.stateVersion = 6;

          # The platform the configuration will be used on.
          nixpkgs.hostPlatform = "aarch64-darwin";
        };
    in
    {
      # Build darwin flake using:
      # $ darwin-rebuild build --flake .#macbook
      darwinConfigurations."macbook" = nix-darwin.lib.darwinSystem {
        modules = [
          configuration
          nix-homebrew.darwinModules.nix-homebrew
          {
            nix-homebrew = {
              enable = true;
              enableRosetta = false;
              user = username;
              # Used to make work when running in GitHub Actions
              autoMigrate = true;
            };
          }

          home-manager.darwinModules.home-manager
          {
            # `home-manager` config
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.${username} = import ./home.nix;
          }
        ];
      };

      darwinPackages = self.darwinConfigurations."macbook".pkgs;
    };
}
