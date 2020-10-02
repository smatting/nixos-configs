with import <nixpkgs> {};

pkgs.python36.withPackages (ps: with ps; [
    numpy
    scipy
    pylint
    flake8

    ipdb
    ipython
    jupyter
])