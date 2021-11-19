#!/usr/bin/env bash

set -e

result=$(sudo nix-build --no-out-link)
sudo nix-env --verbose --profile /nix/var/nix/profiles/system --set $result
sudo $result/bin/switch-to-configuration switch
