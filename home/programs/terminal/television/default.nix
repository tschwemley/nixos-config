{ self, pkgs, ... }: {
  programs = {
    nix-search-tv = {
      enable = true;
      enableTelevisionIntegration = true;
      settings = {
        experimental.options_file = {
          dms = self.inputs.unf.lib.json {
            inherit self pkgs;
            modules = with self.inputs.dms.homeModules; [
              dankMaterialShell
              niri
            ];
          };
        };
      };
    };

    television = {
      enable = true;
      enableZshIntegration = true;

      # REF: https://github.com/alexpasmantier/television/blob/main/.config/config.toml
      # settings = { };
    };
  };
}
