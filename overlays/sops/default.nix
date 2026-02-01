_: prev: {
  sops = prev.sops.overrideAttrs {
    postInstall = /* bash */ ''
      mkdir -p $out/share/zsh/site-functions
      cp ${./_sops} $out/share/zsh/site-functions/_sops
    '';
  };
}
