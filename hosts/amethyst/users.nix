{ pkgs, ...}:
{
    users.users.amethyst = {
        isNormalUser = true;
        extraGroups = [
            "wheel"
            "amethyst"
            "docker"
        ];
        initialHashedPassword = "$y$j9T$vKlDgeLtwFv.fY2gtOb.w0$LtDJ7tHK4Ebg1P5OF7dvKxFO2AqL44NGODCWvCGV8Q0";
        shell = pkgs.zsh;
    };
    users.users.root.shell = pkgs.zsh;
    users.groups.amethyst = { };
}
