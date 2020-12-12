1. `nix-build` to build the system
2. `sudo ./result/bin/switch-to-configuration switch` to activate it
3. `sudo nix-env --verbose --profile /nix/var/nix/profiles/system --set ./result` to add it for next boot
