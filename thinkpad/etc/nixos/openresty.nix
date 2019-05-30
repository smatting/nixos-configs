{stdenv, openresty}:
stdenv.mkDerivation {
    name = "openresty-c";
    src = openresty;
    phases = [ "install" ];
    install = ''
        mkdir -p $out
        cp -r $src/* $out
        cp -r $out/nginx/conf/ $out/conf
    '';
}
