{ config, lib, ... }:
let
  cfg = config.crystal-cavern.starship;
in
{
  config = lib.mkIf cfg.enable {
    programs = {
      starship = {
        enable = true;
        settings = {
          format = "$username$hostname$directory$git_branch$direnv$nix_shell$line_break$character";
          username = {
            format = "[$user]($style)[@](white)";
            style_root = "196";
            style_user = "bold 51";
          };
          git_branch = {
            format = "[$symbol$branch]($style) ";
            style = "242";
          };
          hostname = {
            ssh_only = false;
            trim_at = "";
            format = "[$hostname]($style) ";
            style = "207";
          };
          directory = {
            truncation_length = 16;
            truncation_symbol = "...";
            truncate_to_repo = false;
            format = "[$path]($style) ";
            style = "bold 220";
            home_symbol = "~";
          };
          direnv.disabled = false;
        };
      };
    };
  };
  options.crystal-cavern.starship.enable = lib.mkOption {
    type = lib.types.bool;
    description = "whether to install starship prompt";
    default = true;
  };
}
