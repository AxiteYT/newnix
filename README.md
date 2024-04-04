# axnix

My personal machine's NixOS Configuration

# Installing

```bash
sudo -i

# The root password will be needed for install
passwd root

nix --extra-experimental-features "nix-command flakes" run github:nix-community/nixos-anywhere -- --flake github:/axiteyt/newnix#${FLAKENAME} root@localhost
```
