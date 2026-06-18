_: prev: {
  numi-cli = prev.numr.overrideAttrs (oldAttrs: {
    postInstall = (oldAttrs.postInstall or "") + ''
      ln -s $out/bin/numr $out/bin/numi-cli
    '';
  });
}
