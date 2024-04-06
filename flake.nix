{
  ##########
  # Inputs #
  ##########

  inputs = {
    # Nixpkgs
    nixpkgs.url = "nixpkgs/nixos-unstable";

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

  outputs = inputs @ { self, nixpkgs, disko, home-manager, ... }:
    let
      lib = nixpkgs.lib;
    in
    {
      nixosConfigurations = {
        ####################
        # Installation ISO #
        ####################
        /*
        Build with the following command:
        nix build .#nixosConfigurations.ISO.config.system.build.isoImage
        */

        ISO = lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ({ nixpkgs, ... }: {
              systemd.services.sshd.wantedBy = nixpkgs.lib.mkForce [ "multi-user.target" ];
              users.users.root.openssh.authorizedKeys.keys = [
                "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINMXEwWst3Kkag14hG+nCtiRX8KHcn6w/rUeZC5Ww7RU axite@axitemedia.com"
              ];
            })
            "${nixpkgs}/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix"
            ({ nixpkgs, ... }: {
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
            specialArgs = { inherit inputs self; };
            modules = [
              home-manager.nixosModules.home-manager
              disko.nixosModules.disko
              {
                disko.devices.disk.main.device = "/dev/nvme0n1";
              }
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
      };
    };
}
