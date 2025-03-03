{
  config,
  pkgs,
  lib,
  ...
}: {
  enable = true;
  history.size = 10000;
  #history.path = "${config.xdg.dataHome}/zsh/history";
  oh-my-zsh = {
    enable = true;
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