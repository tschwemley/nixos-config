{ self, ... }:
{
  imports = [ self.inputs.comfyui-nix.nixosModules.default ];

  nixpkgs.overlays = [ self.inputs.comfyui-nix.overlays.default ];

  services.comfyui = {
    enable = true;
    enableManager = true;

    dataDir = "/home/schwem/comfyui";
    extraArgs = [ ];
    gpuSupport = "rocm";
    listenAddress = "127.0.0.1";
    openFirewall = false;
    package = self.inputs.comfyui-nix.packages.x86_64-linux.rocm;
    port = 8188;

    environment = {
      # Important for 7900 XTX (gfx1100)
      HSA_OVERRIDE_GFX_VERSION = "11.0.0";
      # Fix for the LD_LIBRARY_PATH shadowing bug (see note below)
      PYTORCH_ROCM_ARCH = "gfx1100";
    };
  };
}
