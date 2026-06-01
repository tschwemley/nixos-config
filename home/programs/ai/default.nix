{
  self,
  pkgs,
  ...
}:
let
  # inherit (self.inputs.llm-agents.packages.${lib.system pkgs}) crush;

  # openclaw = self.inputs.llm-agents.packages.${lib.system pkgs}.openclaw.overrideAttrs (
  #   finalAttrs: prevAttrs: {
  #     src = pkgs.fetchFromGitHub {
  #       owner = "openclaw";
  #       repo = "openclaw";
  #       rev = "v${finalAttrs.version}";
  #       hash = "sha256-SllmrkkbIFwznUhZ6zogmQ91oCao6d0fMI5473jjrU0=";
  #     };
  #   }
  # );
in
{
  imports = [
    # ./crush.nix
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
