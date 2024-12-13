{secretsPath, ...}: {
  imports = [
    ./containers.nix
    ./services.nix
  ];

  sops.secrets.leantime-env = {
    key = "";
    sopsFile = "${secretsPath}/server/leantime.env";
  };
}
