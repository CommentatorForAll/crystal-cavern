_: {
  programs.delta = {
    enable = true;
    enableGitIntegration = true;
  };
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "rootile";
        email = "git@rootile.de";
      };

      # https://jvns.ca/blog/2024/02/16/popular-git-config-options/
      core = {
        autocrlf = "input";
        editor = "hx";
      };
      github.user = "commentatorforall";
      init.defaultBranch = "main";
      pull.rebase = true;
      merge.conflictstyle = "zdiff3";
      rerere.enabled = true;
      push.autoSetupRemote = true;

      url = {
        "git@github.com:".insteadOf = "gh:";
      };
      alias = {
        plog = "log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset)' --all";
      };
    };

  };
}
