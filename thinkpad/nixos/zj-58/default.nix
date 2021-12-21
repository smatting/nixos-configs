{lib, stdenv, fetchFromGitHub, cups, cmake}:

stdenv.mkDerivation {
  pname = "cups-zj-58";
  version = "2019-04-29";

  # src = fetchFromGitHub {
  #   owner = "klirichek";
  #   repo = "zj-58";
  #   rev = "64743565df4379098b68a197d074c86617a8fc0a";
  #   sha256 = "1g3xa9y1hy46xard34kdgwdg9dwcpg51cvd71g1j71klz92lspz2";
  # };

  src = fetchFromGitHub {
    owner = "smatting";
    repo = "zj-58";
    rev = "95cc82ecd5a78b928c6121e8c1ab65f7335e1e6b";
    sha256 = "1rw5j70ci5xvggvzq14z9zr3g53spznpl21d6xf2f7l1cd6hxlr5";
  };

  nativeBuildInputs = [ cmake ];

  buildInputs = [ cups ];

  installPhase = ''
    install -D rastertozj $out/lib/cups/filter/rastertozj
    install -D $src/zj58.ppd $out/share/cups/model/zjiang/zj58.ppd
    install -D $src/zj80.ppd $out/share/cups/model/zjiang/zj80.ppd
  '';

  meta = with lib; {
    description = "CUPS filter for thermal printer Zjiang ZJ-58";
    homepage = "https://github.com/klirichek/zj-58";
    platforms = platforms.linux;
    maintainers = with maintainers; [ makefu ];
    license = licenses.bsd2;
  };
}
