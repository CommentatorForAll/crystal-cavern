{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.crystal-cavern.zsh;
in
{
  config =
    {
      shells = [ pkgs.zsh ];
    }
    // lib.mkIf cfg.enable {
      programs = {
#         catpuccin = {
#           fzf.enable = true;
#           bat.enable = true;
#         };
        nix-index = {
          enable = true;
          enableZshIntegration = true;
        };
        fzf = {
          enable = true;
          enableZshIntegration = true;
        };
        bat = {
          enable = true;
        };
        eza = {
          enable = true;
          icons = "auto";
          git = true;
        };
        zoxide = {
          enable = true;
          enableZshIntegration = true;
        };
        broot = {
          enable = true;
          enableZshIntegration = true;
        };

        direnv = {
          enable = true;
          enableZshIntegration = true;
          nix-direnv.enable = true;
        };
        zsh = {
          enable = true;
          autocd = true;
          autosuggestion.enable = true;
          enableCompletion = true;
          history = {
            size = 10000;
            save = 10000;
            expireDuplicatesFirst = true;
            ignoreDups = true;
            ignoreSpace = true;
          };
          historySubstringSearch.enable = true;
          oh-my-zsh = {
            enable = true;
            extraConfig = ''
              # don t sort git branches
              zstyle ':completion:*:git-checkout:*' sort false
              # set descriptions format to enable group support
              # NOTE: don't use escape sequences here, fzf-tab will ignore them
              zstyle ':completion:*:descriptions' format '[%d]'
              # force zsh not to show completion menu, which allows fzf-tab to capture the unambiguous prefix
              #zstyle ':completion:*' menu no
              # preview directory's content with eza when completing cd
              zstyle ':fzf-tab:complete:cd:*' fzf-preview '${pkgs.eza} -1 --color=always $realpath'
              zstyle ':fzf-tab:complete:z:*' fzf-preview '${pkgs.eza} -1 --color=always $realpath'
              zstyle ':fzf-tab:complete:systemctl-*:*' fzf-preview 'SYSTEMD_COLORS=1 systemctl status $word'
              zstyle ':completion:*:*:*:*:processes' command "ps -u $USER -o pid,user,comm -w -w"
              zstyle ':fzf-tab:complete:(kill|ps):argument-rest' fzf-flags --preview-window=down:3:wrap

              # switch group using `<` and `>`
              zstyle ':fzf-tab:*' switch-group '<' '>'
            '';
          };

          plugins = [
            {
              name = "fast-syntax-highlighting";
              src = "${pkgs.zsh-fast-syntax-highlighting}/share/zsh/site-functions";
            }
            {
              name = "zsh-nix-shell";
              src = "${pkgs.zsh-nix-shell}/share/zsh-nix-shell";
            }
            {
              name = "zsh-fzf-tab";
              src = "${pkgs.zsh-fzf-tab}/share/fzf-tab";
              file = "fzf-tab.plugin.zsh";
            }
          ];

          shellAliases = {
            cd = "z";
            gc = "nix-collect-garbage --delete-old";
            refresh = "source ${config.home.homeDirectory}/.zshrc";
            show_path = ''
              echo $PATH | tr ':' ' '
            '';
            tree = "eza --tree";
            retoot = "reboot";
            element-desktop = "element-desktop --enable-features=UseOzonePlatform --ozone-platform=wayland";
            webcord = "webcord --enable-features=UseOzonePlatform --ozone-platform=wayland";
          };
          envExtra = ''
            export PATH=$PATH:$HOME/.local/bin
          '';
          localVariables = {
            REPORTTIME=3;
          };
        };
      };
    };
  options.crystal-cavern.zsh.enable = lib.mkOption {
    type = lib.types.bool;
    description = "whether to install zsh";
    default = true;
  };
}
