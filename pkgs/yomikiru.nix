{
  asar,
  dpkg,
  wrapGAppsHook3,
  fetchurl,
  electron,
  stdenv,
  makeWrapper,
  eza,
  lib,
  ...
}:
let

  inherit (stdenv.hostPlatform) system;

  throwSystem = throw "Unsupported system: ${system}";

  pname = "yomikiru";

  version = { x86_64-linux = "2.19.6"; }.${system} or throwSystem;

  hash =
    {
      x86_64-linux = "sha256-856obvgcsRhEPkQ1LGbF84BXUF8udOBXudXWHg8e/gY=";
    }
    .${system} or throwSystem;

  linux = stdenv.mkDerivation {
    inherit pname version;

    src = fetchurl {
      url = "https://github.com/mienaiyami/yomikiru/releases/download/v${version}/Yomikiru-v${version}-amd64.deb";
      inherit hash;
    };

    dontBuild = true;
    dontConfigure = true;
    dontPatchELF = true;
    dontWrapGApps = true;

    nativeBuildInputs = [
      asar
      dpkg
      makeWrapper
      wrapGAppsHook3
    ];

    unpackPhase = ''
      runHook preUnpack

      mkdir opt
      dpkg-deb --fsys-tarfile $src | tar -xv --no-same-permissions --no-same-owner

      ${eza}/bin/eza -R opt
      runHook postUnpack
    '';

    installPhase = let libPath = lib.makeLibraryPath [ stdenv.cc.cc ]; in ''
      runHook preInstall

      mkdir -p "$out/bin"
      cp -R "usr/share" "$out/share"
      cp -R "usr/lib" "$out/lib"

      asar e $out/lib/yomikiru/resources/app.asar asar-unpacked
      find asar-unpacked -name '*.node' -exec patchelf \
        --add-rpath ${libPath} \
        {} \;
      asar p asar-unpacked $out/lib/yomikiru/resources/app.asar

      makeWrapper ${electron}/bin/electron $out/bin/yomikiru \
      --add-flags $out/lib/yomikiru/resources/app.asar

      runHook postInstall
    '';

  };

in
linux
