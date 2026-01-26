self:
(
  _: prev:
  let
    pkgs = self.inputs.charm.packages.${self.lib.system prev};
  in
  {
    inherit (pkgs) crush;

    mods = pkgs.mods.overrideAttrs (oldAttrs: {
      patches = oldAttrs.patches ++ [
        (prev.fetchpatch {
          url = "https://github.com/charmbracelet/mods/pull/603.patch";
          hash = "1ajf4fngscw9zzlzbljsam2blx94xk684n9blbp41pjlccfdw2n7";
        })
      ];
    });

    # nixpkgs.config.allowUnfree = true;
  }
)
