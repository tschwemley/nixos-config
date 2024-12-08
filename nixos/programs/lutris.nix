{pkgs, ...}: let
  lutris = pkgs.lutris.overrideDerivation (_: rec {
    name = "lutris-${version}";
    version = "0.5.18";
    src = pkgs.fetchFromGitHub {
      owner = "lutris";
      repo = "lutris";
      rev = "v${version}";
      hash = "sha256-dI5hqWBWrOGYUEM9Mfm7bTh7BEc4e+T9gJeiZ3BiqmE=";
    };
  });
in {
  environment.systemPackages = [lutris];

  # enable esync compatability (for Lutris)
  security = {
    pam = {
      loginLimits = [
        {
          domain = "schwem";
          item = "nofile";
          type = "hard";
          value = "524288";
        }
      ];
    };
  };

  systemd.extraConfig = "DefaultLimitNOFILE=524288";
  systemd.user.extraConfig = "DefaultLimitNOFILE=524288";
}
