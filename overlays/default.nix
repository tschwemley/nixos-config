{withSystem, ...}: {
  flake.overlays = {
    llama-cpp = final: prev:
      withSystem prev.stdenv.hostPlatform.system (
        # perSystem parameters. Note that perSystem does not use `final` or `prev`.
        {...}: {
          llama-cpp = prev.llama-cpp.override {
            cudaSupport = false;
            openclSupport = true;
            rocmSupport = true;
            # stdenv = pkgs.gcc11Stdenv;
          };
        }
      );

    # ollama = final: prev:
    #   withSystem prev.stdenv.hostPlatform.system (
    #     # perSystem parameters. Note that perSystem does not use `final` or `prev`.
    #     {...}: {
    #       # ollama = prev.
    #     }
    #   );
  };
}
# ollama = (final: prev: {
#   llama-cpp = prev.llama-cpp.override {
#     cudaSupport = false;
#     openclSupport = true;
#     rocmSupport = true;
#     # stdenv = pkgs.gcc11Stdenv;
#   };
# })

