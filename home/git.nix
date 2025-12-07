_: {
  programs.delta = {
    enable = true;
    enableGitIntegration = true;
  };
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "Commentator2.0";
        email = "commentator2.0@crystal-cavern.systems";
      };

      # https://jvns.ca/blog/2024/02/16/popular-git-config-options/
      core = {
        autocrlf = "input";
        editor = "micro";
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
