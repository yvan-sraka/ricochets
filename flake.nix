{
  inputs = {
    nixpkgs.url = "https://channels.nixos.org/nixos-25.11/nixexprs.tar.xz";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
      ...
    }:
    nixpkgs.outputs
    // flake-utils.lib.eachDefaultSystem (system: {
      packages.default = nixpkgs.legacyPackages.${system}.writeShellScriptBin "install" ''
        HARDWARE_LIST=${./hardware-list.tsv} ${./scripts/install}
      '';
    })
    // {
      # If you're using flakes and still want the opinionated defaults for your
      # desktop or laptop computers, do something like:
      #
      #   my_computer = ricochets.lib.nixosSystem {
      #     system = "x86_64-linux";
      #     modules = [
      #       ./path/to/your/configuration.nix
      #       ricochets.nixosModules.default
      #     ];
      #   };
      nixosModules.default = ./nixos/opiniated.nix;
    };
}
