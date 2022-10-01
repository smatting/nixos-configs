{
  nix.settings = {
    substituters = [
      "https://wire-server-test.cachix.org"
    ];
    trusted-public-keys = [
      "wire-server-test.cachix.org-1:G/MfSnKT2z2NuSoE3wcqlFcT41aMOFCL+qUPj96Y9Tw="
    ];
  };
}
