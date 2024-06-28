{ config, lib, pkgs, ... }: {
  services.openvpn.servers = {
    besta = {
      autoStart = true;
      config = "config /root/nixos/openvpn/au727.nordvpn.com.udp1194.ovpn";
      updateResolvConf = true;
      authUserPass = {
        username = builtins.readFile /root/nixos/openvpn/nvpnU;
        password = builtins.readFile /root/nixos/openvpn/nvpnP;
      };
    };
  };
}
