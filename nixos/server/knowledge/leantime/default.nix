{secretsPath, ...}: {
  imports = [
    ./containers.nix
    ./services.nix
  ];

  sops.secrets.leantime-env = {
    format = "dotenv";
    key = "";
    sopsFile = "${secretsPath}/server/leantime.env";
  };
}
