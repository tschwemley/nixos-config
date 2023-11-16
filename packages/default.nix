{...}: {
  perSystem = {
    pkgs,
    lib,
    ...
  }: {
    packages = {
      hyprbars = let
        hyprland = pkgs.hyprland;
      in
        pkgs.stdenv.mkDerivation {
          pname = "hyprbars";
          version = "0.1";
          src = pkgs.fetchFromGitHub {
            owner = "hyprwm";
            repo = "hyprland-plugins";
            rev = "15ac326593db5a6337b0e2ba3db932aada825cd5";
            sha256 = "sha256-ZvV35GsOXLEM3J9/iBBS1CQcwzQt8V3ag0Gb82I89lk=";
          };
          sourceRoot = "source/hyprbars";

          inherit (hyprland) nativeBuildInputs;

          buildInputs = [hyprland] ++ hyprland.buildInputs;
        };
    };
  };
}
