{ pkgs, config, ... }:
{
  home = {
    packages = with pkgs; [
      wofi
    ];
  };
}
