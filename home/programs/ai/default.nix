{
  self,
  pkgs,
  ...
}:
{
  imports = [
    ./llm.nix

    # TODO: split out or delete after trialing
    self.inputs.whisp-away.nixosModules.home-manager

    ./mods.nix
  ];

  # TODO: split out or delete after trialing
  home.packages = [
    # openclaw
    pkgs.openclaw
  ];

  # With home-manager (recommended)
  services.whisp-away = {
    enable = true;
    defaultModel = "small.en"; # Default model (changes apply immediately)
    defaultBackend = "whisper-cpp"; # Backend selection (changes apply immediately)
    accelerationType = "vulkan"; # or "cuda", "openvino", "cpu" - requires rebuild
    useClipboard = false; # Output mode (changes apply immediately)
    useCrane = false; # Enable if you want faster rebuilds when developing
  };
}
