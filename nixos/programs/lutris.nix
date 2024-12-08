{pkgs, ...}: let
  lutris = with pkgs;
    lutris.overrideAttr rec {
      version = "0.5.18";
      src = fetchFromGitHub {
        owner = "lutris";
        repo = "lutris";
        rev = "v${version}";
        hash = "${lib.fakeHash}";
      };
    };
in {
  environment.systemPackages = [lutris];

  # enable esync compatability (for Lutris)
  security = {
    pam = {
      loginLimits = [
        {
          domain = "*";
          item = "nofile";
          type = "-";
          value = "524288";
        }
      ];
    };
  };

  systemd.extraConfig = "DefaultLimitNOFILE=524288";
  systemd.user.extraConfig = "LimitNOFILE=524288";
}
