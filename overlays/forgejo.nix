_: prev: {
  forgejo = prev.forgejo.overrideAttrs (
    _: prevAttrs: {
      postInstall =
        prevAttrs.postInstall
        + ''
          ln -s $out/bin/gitea $out/bin/forgejo
        '';
    }
  );
}
