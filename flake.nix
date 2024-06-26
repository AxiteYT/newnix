{
  ##########
  # Inputs #
  ##########

  inputs = {
    # Nixpkgs
    nixpkgs.url = "nixpkgs/nixos-unstable";

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Disko
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Home-Manager
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  ###########
  # Outputs #
  ###########

  outputs =
    inputs @ { self
    , nixpkgs
    , sops-nix
    , disko
    , home-manager
    , ...
    }:
    let
      lib = nixpkgs.lib;
      user = "axite";
    in
    {
      formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.nixpkgs-fmt;

      nixosConfigurations =
        {
          #######################
          # Installation ISO(s) #
          #######################
          /*
            Build with the following command:
            nix build .#nixosConfigurations.ISO.config.system.build.isoImage
          */

          ISO = nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";
            modules = [
              # Installation CD
              "${nixpkgs}/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix"
              ({ pkgs, ... }: {
                systemd.services.sshd.wantedBy = nixpkgs.lib.mkForce [ "multi-user.target" ];

                # Add SSH keys
                users.users.root.openssh.authorizedKeys.keys = [
                  "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINMXEwWst3Kkag14hG+nCtiRX8KHcn6w/rUeZC5Ww7RU axite@axitemedia.com"
                ];
                environment.systemPackages = [ ];
              })
            ];
          };

          ################
          # NixOS Systems#
          ################

          #### Notes #####
          # Add the following to specify a disk: { disko.devices.disk.main = "/dev/sda"; }

          axnix = lib.nixosSystem
            {
              system = "x86_64-linux";
              specialArgs = { inherit inputs self user; };
              modules = [
                # home-manager
                home-manager.nixosModules.home-manager
                {
                  home-manager.useGlobalPkgs = true;
                  home-manager.useUserPackages = true;
                  home-manager.users.axite = import ./home/axnix.nix;
                  home-manager.extraSpecialArgs = { inherit inputs self user; };
                }

                # disko
                disko.nixosModules.disko
                {
                  disko.devices.disk.main.device = "/dev/nvme0n1";
                }

                # SOPS
                sops-nix.nixosModules.sops

                # Configuration
                ./configuration.nix
                ./hosts/axnix/default.nix
              ];
            };

          besta = lib.nixosSystem
            {
              system = "x86_64-linux";
              modules = [
                disko.nixosModules.disko
                ./configuration.nix
                ./hosts/besta/default.nix
              ];
            };

          plex = lib.nixosSystem
            {
              system = "x86_64-linux";
              modules = [
                disko.nixosModules.disko
                ./configuration.nix
                ./hosts/plex/default.nix
              ];
            };

          munshi = lib.nixosSystem
            {
              system = "x86_64-linux";
              modules = [
                disko.nixosModules.disko
                ./configuration.nix
                ./hosts/munshi/default.nix
              ];
            };

          jeli = lib.nixosSystem
            {
              system = "x86_64-linux";
              modules = [
                disko.nixosModules.disko
                ./configuration.nix
                ./hosts/jeli/default.nix
              ];
            };

          elan = lib.nixosSystem
            {
              system = "x86_64-linux";
              modules = [
                disko.nixosModules.disko
                ./configuration.nix
                ./hosts/elan/default.nix
              ];
            };
        };
    };
}
