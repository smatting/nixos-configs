#!/usr/bin/env bash

set -exo pipefail

sudo nixos-rebuild --flake . switch
