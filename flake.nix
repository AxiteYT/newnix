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

    # NUR
    nur.url = "github:nix-community/NUR";

    # Hardware
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

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

    # Darwin
    nixpkgs-darwin.url = "github:nixos/nixpkgs/nixpkgs-24.05-darwin";

    darwin = {
      url = "github:lnl7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs-darwin";
    };

    # WSL 
    nixos-wsl = {
      url = "github:nix-community/NixOS-WSL";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  ###########
  # Outputs #
  ###########

  outputs =
    inputs@{
      disko,
      home-manager,
      nixos-hardware,
      nixpkgs,
      nur,
      self,
      sops-nix,
      nixos-wsl,
      darwin,
      ...
    }:
    let
      lib = nixpkgs.lib;
      dlib = darwin.lib;
      user = "axite";
    in
    {
      formatter = {
        aarch64-darwin = nixpkgs.legacyPackages.aarch64-darwin.nixfmt-rfc-style;
        x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.nixfmt-rfc-style;
      };

      nixosConfigurations = {
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
            (
              { pkgs, ... }:
              {
                imports = [ ./hardware/qemu-guest/default.nix ];

                systemd.services.sshd.wantedBy = nixpkgs.lib.mkForce [ "multi-user.target" ];

                # Add SSH keys
                users.users.root.openssh.authorizedKeys.keys = [
                  "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINMXEwWst3Kkag14hG+nCtiRX8KHcn6w/rUeZC5Ww7RU axite@axitemedia.com"
                ];
                environment.systemPackages = [ ];
              }
            )
          ];
        };

        ################
        # NixOS Systems#
        ################

        #### Notes #####
        # Add the following to specify a disk: { disko.devices.disk.main = "/dev/sda"; }

        axnix = lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = {
            inherit inputs self user;
          };
          modules = [
            # home-manager
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.axite = import ./home/axnix.nix;
              home-manager.extraSpecialArgs = {
                inherit inputs self user;
              };
            }

            # disko
            disko.nixosModules.disko
            { disko.devices.disk.main.device = "/dev/nvme0n1"; }

            # SOPS
            sops-nix.nixosModules.sops

            # Configuration
            ./configuration.nix
            ./disk-config.nix
            ./hosts/axnix/default.nix
          ];
        };

        axtopair = lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            disko.nixosModules.disko
            ./configuration.nix
            ./disk-config.nix
            ./hosts/axtopair/default.nix
          ];
        };

        besta = lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            disko.nixosModules.disko
            ./configuration.nix
            ./disk-config.nix
            ./hosts/besta/default.nix
          ];
        };

        plex = lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            disko.nixosModules.disko
            ./configuration.nix
            ./disk-config.nix
            ./hosts/plex/default.nix
          ];
        };

        munshi = lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            disko.nixosModules.disko
            ./configuration.nix
            ./disk-config.nix
            ./hosts/munshi/default.nix
          ];
        };

        jeli = lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            disko.nixosModules.disko
            ./configuration.nix
            ./disk-config.nix
            ./hosts/jeli/default.nix
          ];
        };

        xyz = lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            disko.nixosModules.disko
            ./configuration.nix
            ./disk-config.nix
            ./hosts/xyz/default.nix
          ];
        };

        nuehast = lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            disko.nixosModules.disko
            ./configuration.nix
            ./disk-config.nix
            ./hosts/nuehast/default.nix
          ];
        };

        wsl = lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            nixos-wsl.nixosModules.wsl
            ./configuration.nix
            ./hosts/wsl/default.nix
          ];
        };
      };

      darwinConfigurations.axtoppro = darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        modules = [ ./hosts/axtoppro/default.nix ];
      };
    };
}
