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

  outputs =
    inputs @ { self
    , nixpkgs
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
              # CA Certificates
              ./modules/networking/certificates/default.nix

              # Installation CD
              "${nixpkgs}/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix"
              ({ pkgs, ... }: {
                systemd.services.sshd.wantedBy = nixpkgs.lib.mkForce [ "multi-user.target" ];

                # Add SSH keys
                users.users.root.openssh.authorizedKeys.keys = [
                  "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINMXEwWst3Kkag14hG+nCtiRX8KHcn6w/rUeZC5Ww7RU axite@axitemedia.com"
                  "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAII6p03Ji2xOOKp032K2HUnhaqrlDI+fW+ncFqCLsyLOW IT.Manager@aciar.gov.au"
                  "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDjF3z+7X4vuucilcqihYSmOTiv4e913Kt8ie7VnCY8T9Z0FGHaOioFEl/xklvBpXkwHNPjI+Ts7VK34yWVXb3DZn/CaCht1miAelPihavwq9WUM7xuNecieRQVL7NCD/VfVzr3j2JLY7PzOMrPn0n7f2S5jyOqRFMe5t65KmPU/MXVl7gIChgaqgO/AzzFGBSU/kI7gnjet7zdtus0hndVbPh66l6twV6MCmspmlv2zJVgqxpFekTpsCuZDDa1ihSxFxEzvFcR4HWxjwrlum6RUbjV95LpNhygMkgVkM+8m7Ew1phX00I1YS2/xPoJtMCvrdP+Qk0wOXwdWfu9IJddNh5EkgaBsSHIMU/9oNUiIPSeJD8nB1m07YVFbwvYarMwAdzBTbKm9Op7JLl4KQ9dEvlwQren5q7UUFICML+rK4pZZ6NkIg33Cc5KN1FeT5M2yDJpOexEGI5YXudreUIQXPimTQHxuXROeDTKA3/ShZzVtDhNgILzZq5at52D18KwgfCWqpJrYUKxzHw/EveG39ci52WhL8OsGy64ZcnFYhU165tmy+ViTLHkcKEGbjLPCfxrM1dD2N57R8i7f/pHnaQEmf7ifCqZNfSe7FRSKdB+aYzpRYGrzUlLpsO06co6Fj5NEG8xxWwdCoSv7cMa7BCpUO78rHaCroiqH2iXgQ== aciarcodefetcher@aciar.gov.au"
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

                # Configuration
                ./configuration.nix
                ./hosts/default.nix
                ./hosts/axnix/default.nix
              ];
            };

          besta = lib.nixosSystem
            {
              system = "x86_64-linux";
              modules = [
                disko.nixosModules.disko
                ./configuration.nix
                ./hosts/default.nix
                ./hosts/besta/default.nix
              ];
            };

          plex = lib.nixosSystem
            {
              system = "x86_64-linux";
              modules = [
                disko.nixosModules.disko
                ./configuration.nix
                ./hosts/default.nix
                ./hosts/plex/default.nix
              ];
            };

          munshi = lib.nixosSystem
            {
              system = "x86_64-linux";
              modules = [
                disko.nixosModules.disko
                ./configuration.nix
                ./hosts/default.nix
                ./hosts/munshi/default.nix
              ];
            };
        };
    };
}
