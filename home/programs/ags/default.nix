{inputs, ...}: {
  imports = [inputs.ags.homeManagerModules.default];

  programs.ags = {
    enable = true;
    configDir = ./config;

    # TODO: uncomment if necessary
    # extraPackages = [];
  };
}
