{ pkgs, lib, ... }:
{
  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];
    auto-optimise-store = false;
  };
  nixpkgs.config.allowUnfree = true;

  # activationScripts are executed every time you boot the system or run `nixos-rebuild` / `darwin-rebuild`.
  system = {
    activationScripts.postUserActivation.text = ''
      # activateSettings -u will reload the settings from the database and apply them to the current session,
      # so we do not need to logout and login again to make the changes take effect.
      /System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u
    '';
  };

  # Shell
  security.pam.enableSudoTouchIdAuth = true;
  programs.zsh.enable = true;
  environment.shells = [ pkgs.zsh ];

  # Timezone
  time.timeZone = "Australia/Sydney";

  # Fonts
  fonts = {
    packages = with pkgs; [
      material-design-icons
      font-awesome
      (nerdfonts.override {
        fonts = [
          "NerdFontsSymbolsOnly"
          "FiraCode"
          "JetBrainsMono"
          "Iosevka"
        ];
      })
    ];
  };
}
