#!/usr/bin/env bash

set -e

nix-build
sudo nix-env --verbose --profile /nix/var/nix/profiles/system --set ./result
sudo ./result/bin/switch-to-configuration switch
