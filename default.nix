let
  sources = import ./npins;
  nixpkgs = import sources.nixpkgs;
in
nixpkgs
