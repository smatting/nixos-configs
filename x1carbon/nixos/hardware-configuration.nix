# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, ... }:

{
  imports =
    [ <nixpkgs/nixos/modules/installer/scan/not-detected.nix>
    ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "nvme" "usb_storage" "sd_mod" "rtsx_pci_sdmmc" ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];
  boot.supportedFilesystems = [ "ntfs-3g" ];

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/cf1fa5b1-b3f7-4e39-880b-204945e5f8c0";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/B77D-DBC4";
      fsType = "vfat";
    };

  swapDevices = [ ];

  nix.maxJobs = lib.mkDefault 4;
  powerManagement.cpuFreqGovernor = "powersave";

  hardware.bluetooth.enable = true;
  hardware.bluetooth.disabledPlugins = [ "sap" ];

  hardware.pulseaudio.package = pkgs.pulseaudioFull;

  hardware.sane.enable = true;
  hardware.sane.extraBackends = [ pkgs.sane-airscan ];
}
