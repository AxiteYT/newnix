{
  networking = {
    # Domain
    domain = "axitemedia.com";
  };

  # Add axite user
  users.users.axite = {
    isNormalUser = true;
    description = "Kyle Smith";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
  };
}
