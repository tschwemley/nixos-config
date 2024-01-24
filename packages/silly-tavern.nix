{pkgs, ...}:
with pkgs;
  buildNpmPackage {
    pname = "silly-tavern";
    version = "staging";
    src = fetchFromGitHub {
      owner = "SillyTavern";
      repo = "SillyTavern";
      rev = "958cf6a373d612485ccfaaec681797521f750cfe";
      hash = "sha256-rJI1ahn8SCiKCfWpXRFlby1jv03n1WVmgGJ5RQ4LOmM=";
    };

    npmDepsHash = "sha256-5jIPncFkKcqO1ssohEgnmACElHKxG6a0Yq13217gH74=";
    dontNpmBuild = true;

    postInstall = ''
      cp $src/default/config.yaml $out/config.yaml
      cp $src/default/config.yaml $out/bin/config.yaml
    '';
  }
