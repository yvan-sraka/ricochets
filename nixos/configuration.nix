{ ... }:
{
  # Main ricochets configuration entry point
  # This replaces the standard nixpkgs/nixos when channel is set to ricochets
  imports = [
    # Import user config (default is /etc/nixos/configuration.nix)
    # N.B.: The ENV variable NIXOS_CONFIG is ignored; use the -f flag instead!
    <nixos-config>
    # Backported modules to prevent breakage on NixOS updates
    ./backported.nix
    # Opinionated defaults for desktop/laptop usage
    ./opiniated.nix
  ];
}
