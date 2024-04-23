{ config, pkgs, ... }:

{
  # Setup Nix to use the remote builder
  nix = {
    distributedBuilds = true;
    buildMachines = [{
      hostName = "192.168.1.7";
      sshUser = "builduser";
      system = "x86_64-linux";
      maxJobs = 1;
      speedFactor = 5;
      supportedFeatures = [ "big-parallel" "benchmark" ];
    }];
  };

  # SSH client configuration for root, assuming root is used for builds
  programs.ssh = {
    extraConfig = ''
      Host 192.168.1.7
      Hostname 192.168.1.7
      User builduser
      IdentityFile /root/.ssh/nix_builder_key
      IdentitiesOnly yes
      StrictHostKeyChecking accept-new
    '';
  };

  # Generate SSH keys for root, manage manually if security policies vary
  # This can be managed outside of Nix for greater control
  users.users.root = {
    openssh.authorizedKeys.keys = [ "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCjeX/x/7ZS4gKFmTHf29FTVcA7hjrZciNjkJxMPlhRBnt20jvj8Xyy4hu+OipYogAPv1k1DDgXiNgZ+Eb2xaomko7o9GWcoUOOGbD7LEjisyaL2C7LvoFzKIJeQJ87Dk12eaPD41Vjd/sD7oTqWDig6pfRovRfdXjO3oE3M4igRkis8Y7jWHVIyi7cD3jbb2X+QPQmCZLmsMiFvj/6J1r9unDS7jW0vERI7404NxhXLQTwwVv4t86ka4Rcs4EiDmWquBQ5sLQg7iVn/XPmShw/RluGh+eJDEUITsG5+d9QrickozFRL87gnfVI3Pbm0Nc6DfN8KFhiaveNebGoUZY34K8w+lbQHYrXT+j/Dh5N6+HNO97eq1zf+Auv5HLLo13nP/dS+uqhC+kC6aZqTKL7tSAnRCc717Ua1C32fSdXK5H5vZmeD+BFGpekBSbLiEz4J1+vfXO4A9bu9wono7m0gkV+WqAB4OJ6n/AMa7G0R48bHwUTRRg7JIkEknL9ljLUlreGJWyT5q484sWE4Tg/PsAsQMMYpO2h3uz5J6dMlnEjYHNxspPD9D5UZjyw3tJ8Ifbliqz/fPD2cTGxkz4dIEyHjWIhmvQrO3UNxS2gTrdSaC8/HpREtZWADIZfxz5cU2apLeuNyZPn3/UG8DkFOLhcU6qPePq0o3QFjbpdNw== nix-builder@axitemedia.com" ];
  };
}
