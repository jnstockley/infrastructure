# Install
## Ensure Terminal.app has full disk access
1. Open System Settings
2. Go to Security & Privacy
3. Go to Full Disk Access
4. Add Terminal.app

```bash
curl https://raw.githubusercontent.com/jnstockley/infrastructure/refs/heads/main/nix/macbook-pro/setup.sh | zsh
```

### Install (beta)
```bash
curl https://raw.githubusercontent.com/jnstockley/infrastructure/refs/heads/beta/nix/macbook-pro/setup.sh | zsh
```

## TODO
- [X] Setup Oh My ZSH
  - [X] Need to setup and learn home-manager
- [ ] Add ⌘ + Space hotkey to Raycast
- [ ] Install PyCharm and IntelliJ (maybe through toolbox?)
- [ ] Copy existing settings to flake.nix file
  - TODO Determine list of settings to copy
- [X] CI/CD Tests for install script and flake.nix
- [X] Update folder list on left side in finder
  - [ ] Fix folder paths
- [ ] Fix automatic updates
- [X] Make script repeatable i.e. check if nix installed, check if files exist, etc.