_: prev: {
  sops = prev.sops.overrideAttrs {
    # don't install the bash and zsh autocompletion scripts from nixpkgs. they don't allow sops <path> completion
    postInstall = "";
  };
}
