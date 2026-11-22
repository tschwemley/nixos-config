final: prev: {
  linux_zen_custom =
    let
      version = "7.3.4";
      hash = "sha256-k1tbY69qU0RRlX5xY+GwH548meeIQ9r3HBnX1ByFT+w=";
      modDirVersion = "${version}-zen2";
    in
    prev.linux_zen.override {
      argsOverride = {
        inherit
          version
          modDirVersion
          ;

        src = final.fetchFromGitHub {
          owner = "zen-kernel";
          repo = "zen-kernel";
          rev = "v${modDirVersion}";
          inherit hash;
        };
      };
    };

  linux_zen_custom-packages = final.linuxPackagesFor final.linux_zen_custom;
}
