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
        home.packages = with pkgs; [ lutris ];
        programs = {
            steam = {
                enable = true;
            };
        };
    };

    options.crystal-cavern.gayming = lib.mkOption {
        type = lib.types.bool;
        description = "If you want to do gayming";
        default = false;
    };
}
