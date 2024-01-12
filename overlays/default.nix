{withSystem, ...}: {
  flake.overlays.ollama = final: prev:
    withSystem prev.stdenv.hostPlatform.system (
      # perSystem parameters. Note that perSystem does not use `final` or `prev`.
      {...}: {
        # ollama = prev.
      }
    );
}
