{
  config,
  pkgs,
  lib,
  ...
}: {
  enable = true;
  history.size = 10000;
  history.path = "${config.xdg.dataHome}/zsh/history";
  shellAliases = {
    ls = "ls -la --color";
    nix-update = "nix run nix-darwin --extra-experimental-features \"nix-command flakes\" -- switch --flake ~/.config/nix#macbook --impure";
  };
  initExtra = ''
    export PATH="/Users/jackstockley/.local/bin:$PATH"

    export LDFLAGS="-L/opt/homebrew/opt/libpq/lib"
    export CPPFLAGS="-I/opt/homebrew/opt/libpq/include"

    export PYENV_ROOT="$HOME/.pyenv"
    [[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
    eval "$(pyenv init -)"

    export NVM_DIR="$HOME/.nvm"
      [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
      [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion
  '';
  oh-my-zsh = {
    enable = true;
    theme = "robbyrussell";
    plugins = [
      "git"
      "docker"
    ];
  };
  plugins = [
    #{
    # will source zsh-autosuggestions.plugin.zsh
    #name = "zsh-autosuggestions";
    #src = pkgs.zsh-autosuggestions;
    #file = "share/zsh-autosuggestions/zsh-autosuggestions.zsh";
    #}
    {
      name = "zsh-completions";
      src = pkgs.zsh-completions;
      file = "share/zsh-completions/zsh-completions.zsh";
    }
    {
      name = "zsh-syntax-highlighting";
      src = pkgs.zsh-syntax-highlighting;
      file = "share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh";
    }
  ];
}