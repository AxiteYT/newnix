{ pkgs, ... }:
{
  # Enable GPU Driivers
  hardware = {
    graphics = {
      enable = true;
      enable32Bit = true;

      # Enable OpenCL
      extraPackages = with pkgs; [ rocmPackages.clr.icd ];
    };
  };

  # HIP Config
  systemd = {
    tmpfiles.rules =
      let
        rocmEnv = pkgs.symlinkJoin {
          name = "rocm-combined";
          paths = with pkgs.rocmPackages; [
            rocblas
            hipblas
            clr
          ];
        };
      in
      [
        "L+    /opt/rocm   -    -    -     -    ${rocmEnv}"
      ];

    # LACT
    packages = with pkgs; [ lact ];
    services.lactd.wantedBy = [ "multi-user.target" ];
  };

  # LACT Package
  environment.systemPackages = with pkgs; [ lact ];
}
