{ stdenv, fetchgit, cmake, supercollider, fftw, libsndfile }:

let plugins = stdenv.mkDerivation rec {

    version = "3.11.1";
    name = "sc3-plugins-${version}";

    # Release 3.11.1
    src = fetchgit {
      url = "https://www.github.com/supercollider/sc3-plugins.git";
      rev = "209cf4ffdcc9181b37aedbf4902e4b4d4090d505";
      sha256 = "sha256-CMryjUzZBVBu5zGMQhJL24uMDf+ObPMaoXXGuqt4x7M=";
      fetchSubmodules = true;
    };

    buildInputs = [ cmake supercollider fftw libsndfile ];

    cmakeFlags = [
      "-DSUPERNOVA=ON"
      "-DSC_PATH=${supercollider}/include/SuperCollider"
      "-DFFTW3F_LIBRARY=${fftw}/lib/"
    ];

    buildPhase = ''
      cmake .
      cmake --build . --config Release
      cmake --build . --config Release --target install
    '';
  };
in
supercollider.overrideAttrs(oldAttrs: oldAttrs //
 {
   postInstall = ''
    cp -r ${plugins}/lib/SuperCollider/plugins/* $out/lib/SuperCollider/plugins/
    cp -r ${plugins}/share/SuperCollider/Extensions/* $out/share/SuperCollider/Extensions/
  '';
 }
)
