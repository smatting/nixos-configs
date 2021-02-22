{ config, lib, pkgs, ... }:

with pkgs;

stdenv.mkDerivation rec {
  name = "spruce";
  version = "1.27.0";
  src = fetchurl {
    url = "https://github.com/geofffranks/spruce/releases/download/v${version}/spruce-linux-amd64";
    sha256 = "1v1lwx3xgaa7ahlh07kacaw7rz1y5vwaqjqj5xa0jdyzmh0hnznd";
  };
  phases = [ "installPhase" ];
  installPhase = ''
    mkdir -p "$out/bin/";
    cp "$src" "$out/bin/spruce";
    chmod +x "$out/bin/spruce";
  '';
}
