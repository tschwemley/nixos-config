{ self, ... }:
{
  imports = [
    self.inputs.whisp-away.nixosModules.home-manager
  ];

  # TODO:
  # TBD: is this needed? should this be used in place of whisp away?
  # ---
  # home.packages = with pkgs; [
  #   whisper-cpp-vulkan
  # ];
  #

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
