{inputs, ...}: {
  # add the home manager module
  imports = [inputs.ags.homeManagerModules.default];

  programs.ags = {
    enable = true;

    # null or path, leave as null if you don't want hm to manage the config
    configDir = ./config;

    # TODO: decide what (if any) extra packages I want to include in gtk's js runtime
    # additional packages to add to gjs's runtime
    # extraPackages = with pkgs; [
    #   gtksourceview
    #   webkitgtk
    #   accountsservice
    # ];
  };
}
