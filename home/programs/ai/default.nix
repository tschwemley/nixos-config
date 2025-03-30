{
  self,
  pkgs,
  ...
}: {
  imports = [./mods.nix];

  home.packages = with pkgs; [
    aider-chat
    lmstudio
    ollama
    piper-tts
  ];

  sops.secrets = let
    mode = "0400";
    sopsFile = "${self.lib.secrets.home}/ai.yaml";
  in {
    openrouter_api_key = {
      inherit mode sopsFile;
      key = "openrouter_api_key";
    };

    open_webui_api_key = {
      inherit mode sopsFile;
      key = "open_webui_api_key";
    };
  };
}
