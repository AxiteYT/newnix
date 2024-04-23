{ config, pkgs, ... }:

{
  # Ensure SSH is enabled and properly configured
  services.openssh = {
    enable = true;
    permitRootLogin = "no";
    extraConfig = ''
      AllowUsers builduser
    '';
  };

  # Setup user for builds
  users.users.builduser = {
    isNormalUser = true;
    home = "/home/builduser";
    createHome = true;
    description = "Nix Build User";
    extraGroups = [ "nixbld" ]; # Add to nixbld to allow Nix operations
    openssh.authorizedKeys.keys = [ "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCjeX/x/7ZS4gKFmTHf29FTVcA7hjrZciNjkJxMPlhRBnt20jvj8Xyy4hu+OipYogAPv1k1DDgXiNgZ+Eb2xaomko7o9GWcoUOOGbD7LEjisyaL2C7LvoFzKIJeQJ87Dk12eaPD41Vjd/sD7oTqWDig6pfRovRfdXjO3oE3M4igRkis8Y7jWHVIyi7cD3jbb2X+QPQmCZLmsMiFvj/6J1r9unDS7jW0vERI7404NxhXLQTwwVv4t86ka4Rcs4EiDmWquBQ5sLQg7iVn/XPmShw/RluGh+eJDEUITsG5+d9QrickozFRL87gnfVI3Pbm0Nc6DfN8KFhiaveNebGoUZY34K8w+lbQHYrXT+j/Dh5N6+HNO97eq1zf+Auv5HLLo13nP/dS+uqhC+kC6aZqTKL7tSAnRCc717Ua1C32fSdXK5H5vZmeD+BFGpekBSbLiEz4J1+vfXO4A9bu9wono7m0gkV+WqAB4OJ6n/AMa7G0R48bHwUTRRg7JIkEknL9ljLUlreGJWyT5q484sWE4Tg/PsAsQMMYpO2h3uz5J6dMlnEjYHNxspPD9D5UZjyw3tJ8Ifbliqz/fPD2cTGxkz4dIEyHjWIhmvQrO3UNxS2gTrdSaC8/HpREtZWADIZfxz5cU2apLeuNyZPn3/UG8DkFOLhcU6qPePq0o3QFjbpdNw== nix-builder@axitemedia.com" ];
  };

  # Configure Nix Daemon to allow remote builds
  nix = {
    distributedBuilds = true;
    buildMachines = [{
      hostName = "localhost";
      system = "x86_64-linux";
      protocol = "ssh-ng";
      maxJobs = 20;
      speedFactor = 10;
    }];
    settings = {
      trusted-users = [
        "root"
        "builduser"
        "@wheel"
      ];
    };
  };
}
