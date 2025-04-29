# treefmt.nix
{ pkgs, ... }:

{
  projectRootFile = "flake.nix";

  programs = {
    nixfmt-rfc-style.enable = true;
    prettier.enable = true;
    shfmt.enable = true;
  };
}
