# flake.nix
{
  ##########
  # Inputs #
  ##########

  inputs = {
    # Nixpkgs
    nixpkgs.url = "nixpkgs/nixos-unstable";

    # flake-utils
    flake-utils.url = "github:numtide/flake-utils";

    # SOPS
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
    nixpkgs-darwin.url = "nixpkgs/nixpkgs-24.11-darwin";
    darwin = {
      url = "github:lnl7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs-darwin";
    };

    # WSL
    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";

    # treefmt
    treefmt-nix.url = "github:numtide/treefmt-nix";
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
      nixpkgs-darwin,
      ...
    }:
    let
      lib = nixpkgs.lib;
      dlib = darwin.lib;
      user = "axite";

      # shared formatter config
      cfg = {
        projectRootFile = "flake.nix";
        programs = {
          nixfmt.enable = true;
          prettier.enable = true;
          shfmt.enable = true;
        };
      };

      treefmtX86 = inputs.treefmt-nix.lib.evalModule nixpkgs.legacyPackages.x86_64-linux cfg;

      treefmtDarwin = inputs.treefmt-nix.lib.evalModule nixpkgs-darwin.legacyPackages.aarch64-darwin cfg;
    in
    {
      formatter = {
        x86_64-linux = treefmtX86.config.build.wrapper;
        aarch64-darwin = treefmtDarwin.config.build.wrapper;
      };

      ################
      # NixOS Systems#
      ################

      nixosConfigurations = {
        #######################
        # Installation ISO(s) #
        #######################
        /*
          Build with the following command:
          nix build .#nixosConfigurations.ISO.config.system.build.isoImage
        */
        ISO = lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            # Installation CD
            "${nixpkgs}/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix"
            (
              { pkgs, ... }:
              {
                imports = [ ./hardware/qemu-guest ];

                systemd.services.sshd.wantedBy = nixpkgs.lib.mkForce [ "multi-user.target" ];

                # Enable serial port
                boot.kernelParams = [ "console=ttyS0,115200n8" ];

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
          specialArgs = { inherit inputs self user; };
          modules = [
            # home-manager
            home-manager.nixosModules.home-manager
            {
              home-manager.users.axite = import ./home/axite.nix;
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
            ./disk-config.nix
            ./hosts/axnix
          ];
        };

        dojo = lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            disko.nixosModules.disko
            { disko.devices.disk.main.device = "/dev/sdb"; }
            ./configuration.nix
            ./disk-config.nix
            ./hosts/dojo
          ];
        };

        axtopair = lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            disko.nixosModules.disko
            sops-nix.nixosModules.sops
            ./configuration.nix
            ./disk-config.nix
            ./hosts/axtopair
          ];
        };

        besta = lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            disko.nixosModules.disko
            sops-nix.nixosModules.sops
            ./configuration.nix
            ./disk-config.nix
            ./hosts/besta
          ];
        };

        plex = lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            disko.nixosModules.disko
            sops-nix.nixosModules.sops
            ./configuration.nix
            ./disk-config.nix
            ./hosts/plex
          ];
        };

        munshi = lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            disko.nixosModules.disko
            sops-nix.nixosModules.sops
            ./configuration.nix
            ./disk-config.nix
            ./hosts/munshi
          ];
        };

        jeli = lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            disko.nixosModules.disko
            sops-nix.nixosModules.sops
            ./configuration.nix
            ./disk-config.nix
            ./hosts/jeli
          ];
        };

        xyz = lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            disko.nixosModules.disko
            sops-nix.nixosModules.sops
            ./configuration.nix
            ./disk-config.nix
            ./hosts/xyz
          ];
        };

        nuehast = lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            disko.nixosModules.disko
            sops-nix.nixosModules.sops
            ./configuration.nix
            ./disk-config.nix
            ./hosts/nuehast
          ];
        };

        wsl = lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            nixos-wsl.nixosModules.default
            {
              system.stateVersion = "24.05";
              wsl.enable = true;
            }
            sops-nix.nixosModules.sops
            ./configuration.nix
            ./hosts/wsl
          ];
        };
      };

      bedrock = lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          disko.nixosModules.disko
          sops-nix.nixosModules.sops
          ./configuration.nix
          ./disk-config.nix
          ./hosts/bedrock
        ];
      };

      ########################
      # Darwin configurations#
      ########################
      darwinConfigurations = {
        axtoppro = dlib.darwinSystem {
          system = "aarch64-darwin";
          modules = [ ./hosts/axtoppro ];
        };
      };
    };
}
