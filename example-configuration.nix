{
  config,
  lib,
  pkgs,
  ...
}:
{
  # TODO: Put here the full content of what the current installer (25.05)
  # generates in /etc/nixos/configuration.nix

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # This option breaks for NixOS versions > 24.05, this is just a PoC for the
  # sake of showing off that this idea works!
  sound.enable = true;

  system.stateVersion = "24.05";
}
