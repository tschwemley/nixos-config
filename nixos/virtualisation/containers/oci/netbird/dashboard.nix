{pkgs, ...}: let
  netbird-dash = with pkgs;
    buildNpmPackage rec {
      pname = "netbird-dashboard";
      version = "2.0.4";

      src = fetchFromGitHub {
        owner = "netbirdio";
        repo = "dashboard";
        rev = "v${version}";
        hash = "${lib.fakeHash}";
      };

      npmDepsHash = "sha256-tuEfyePwlOy2/mOPdXbqJskO6IowvAP4DWg8xSZwbJw=";
    };
in {
  inherit netbird-dash;
}
