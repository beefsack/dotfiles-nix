{
  description = "beefsack's NixOS flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    # home-manager, used for managing user configuration
    home-manager = {
      url = "github:nix-community/home-manager/master";
      # The `follows` keyword in inputs is used for inheritance.
      # Here, `inputs.nixpkgs` of home-manager is kept consistent with
      # the `inputs.nixpkgs` of the current flake,
      # to avoid problems caused by different versions of nixpkgs.
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # Temporary workaround for lanzaboote rust unpacking issue
    # See: https://github.com/nix-community/lanzaboote/issues/485
    # Can be removed once lanzaboote updates its rust-overlay dependency
    rust-overlay.url = "github:oxalica/rust-overlay";
    # lanzaboote for secure boot support
    lanzaboote = {
      url = "github:nix-community/lanzaboote/v0.4.2";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.rust-overlay.follows = "rust-overlay";
    };
  };

  outputs =
    {
      nixpkgs,
      home-manager,
      lanzaboote,
      ...
    }:
    let
      # Common modules for all hosts
      commonModules = [
        ./configuration.nix
        lanzaboote.nixosModules.lanzaboote
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.beefsack = import ./home.nix;
          home-manager.backupFileExtension = "backup";
        }
      ];

      # Function to create a NixOS configuration for a host
      mkHost =
        hostname:
        nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = commonModules ++ [
            ./hosts/${hostname}/hardware-configuration.nix
            ./hosts/${hostname}/configuration.nix
          ];
        };
    in
    {
      nixosConfigurations = {
        beefsack-den = mkHost "beefsack-den";
        beefsack-house = mkHost "beefsack-house";
        beefsack-usb = mkHost "beefsack-usb";
      };
    };
}
