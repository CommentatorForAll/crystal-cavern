{
    config,
    lib,
    pkgs,
    ...
}:
let
    enabled = config.crystal-cavern.gayming;
in
{
    config = lib.mkIf enabled {
    	nixpkgs.config.allowUnfree = true;
        home.packages = with pkgs; [ lutris ];
        programs = {
        };
    };

    options.crystal-cavern.gayming = lib.mkOption {
        type = lib.types.bool;
        description = "If you want to do gayming";
        default = false;
    };
}
