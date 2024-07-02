# newnix

My personal machines' NixOS Configurations

## Installing

```bash
sudo -i

# The root password will be needed for install, unless you modify the ISO with your own SSH key
passwd root

nix --extra-experimental-features "nix-command flakes" run github:nix-community/nixos-anywhere -- --flake github:/axiteyt/newnix#${FLAKENAME} root@localhost
```

## Using munshi (remote building)

There is an option to use a remote machine to build your configuration, for me that is munshi.

You will either need to set the password on each machine remotely (yuck) or include a public SSH key of your own under users.users.root.openssh.authorizedKeys.keys

Once the above is all sorted, you can build a machine with the following command:

### From remote machine

```bash
sudo nixos-rebuild --target-host root@${TARGET_IP/FQDN} --flake github:axiteyt/newnix${FLAKENAME} switch
```

### From target machine

```bash
sudo nixos-rebuild --build-host root@${TARGET_IP/FQDN} --flake github:axiteyt/newnix${FLAKENAME} switch
```
