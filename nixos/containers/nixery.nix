{ nixery-pkgs, nix, pkgs, ... }:

let
  description = "Nixery";
  storagePath = "/var/lib/nixery";

  nixery = nixery-pkgs.nixery.overrideAttrs(old: {
    # Drop the nix-1p documentation page as it doesn't build in pure evaluation.
    postInstall = ''
      wrapProgram $out/bin/server \
        --prefix PATH : ${nixery-pkgs.nixery-prepare-image}/bin \
        --prefix PATH : ${nix}/bin
    '';
  });
in
{
  systemd.services.nixery = {
    inherit description;
    wantedBy = [ "multi-user.target" ];

    serviceConfig = {
      DynamicUser = true;
      StateDirectory = "nixery";
      Restart = "always";
      ExecStartPre = "${pkgs.coreutils}/bin/mkdir -p ${storagePath}";
      ExecStart = "${nixery}/bin/server";
    };

    environment = {
      PORT = "8080";
      NIXERY_PKGS_PATH = pkgs.path;
      NIXERY_STORAGE_BACKEND = "filesystem";
      NIX_TIMEOUT = "60";
      STORAGE_PATH = storagePath;
      WEB_DIR = "/dev/null";
    };
  };
}
