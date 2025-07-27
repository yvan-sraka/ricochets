{ config, lib, ... }:
{
  # Backport deprecated options to prevent user config breakage
  # When NixOS removes options, this module restores them for compatibility

  # Disable the default alsa.nix module (it removes sound.enable)
  disabledModules = [ "services/audio/alsa.nix" ];

  imports = [
    # TODO: Use IFDs to fetch https://github.com/NixOS/nixpkgs/blob/nixos-25.05/nixos/modules/services/audio/alsa.nix,
    # apply a patch to remove lines 56-59:
    #
    #   (lib.mkRemovedOptionModule [ "sound" "enable" ] ''
    #       The option was heavily overloaded and can be removed from most configurations.
    #       To specifically configure the user space part of ALSA, see `hardware.alsa`.
    #   '')
    #
    # ... and import the result
  ];

  # Restore sound.enable option (removed in NixOS 25.05+)
  # This prevents breakage for users who have sound.enable = true in their config
  options.sound.enable =
    with lib;
    mkOption {
      type = types.bool;
      default = false;
    };
}
