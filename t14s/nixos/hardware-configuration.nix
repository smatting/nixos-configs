# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, ... }:

{
  imports =
    [ <nixpkgs/nixos/modules/installer/scan/not-detected.nix>
    ];

  boot.initrd.availableKernelModules = [ "nvme" "ehci_pci" "xhci_pci" "usb_storage" "sd_mod" "rtsx_pci_sdmmc" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-amd" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/4961bd05-9d76-46a1-b98c-6340369be619";
      fsType = "ext4";
    };

  boot.initrd.luks.devices."cryptroot".device = "/dev/disk/by-uuid/bea603d3-0786-4417-8c0b-50b9cfb84adb";

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/6B65-36FA";
      fsType = "vfat";
    };

  swapDevices = [{device = "/dev/nvme0n1p4";}];

  nix.maxJobs = lib.mkDefault 16;
}
