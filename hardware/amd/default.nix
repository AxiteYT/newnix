{ pkgs, ... }:
{
  # Enable GPU Driivers
  hardware = {
    graphics = {
      enable = true;
      enable32Bit = true;
    };
  };

  # LACT
  systemd = {
    packages = with pkgs; [ lact ];
    services.lactd.wantedBy = [ "multi-user.target" ];
  };

  # LACT Package
  environment.systemPackages = with pkgs; [ lact ];
}
