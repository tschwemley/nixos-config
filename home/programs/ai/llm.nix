{
  self,
  pkgs,
  ...
}:
{
  imports = [
    # ./aider.nix
  ];

  home = {
    packages = with pkgs; [
      crush
    ];
  };

  sops.secrets =
    let
      mode = "0400";
      sopsFile = "${self.lib.secrets.home}/ai.yaml";
    in
    {
      openrouter_api_key = {
        inherit mode sopsFile;
        key = "openrouter_api_key";
      };
    };
}
