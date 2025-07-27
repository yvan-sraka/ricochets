# NixOS system builder (used by channels)
# This is invoked when users run nixos-rebuild with ricochets channel
{
  configuration ? ./configuration.nix, # Default to ricochets config
  system ? builtins.currentSystem, # Auto-detect system architecture
}:
let
  sources = import ../npins; # Load pinned nixpkgs version
  nixos = import "${sources.nixpkgs}/nixos"; # NixOS module system
in
nixos { inherit configuration system; }
