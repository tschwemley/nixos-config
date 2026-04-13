{
  config,
  lib,
  pkgs,
  ...
}:

with lib;

let
  cfg = config.services.dufs;

  dufsCmd = ''
    ${cfg.package}/bin/dufs \
      -p ${toString cfg.port} \
      ${if cfg.allowAll then "-A" else ""} \
      ${lib.concatStringsSep " " cfg.extraArgs} \
      ${cfg.servePath}
  '';
in
{
  options.services.dufs = {
    enable = mkEnableOption "dufs - A file server that supports static serving, uploading, searching, accessing control, webdav...";

    package = mkOption {
      type = types.package;
      default = pkgs.dufs;
      defaultText = literalExpression "pkgs.dufs";
      description = "The dufs package to use.";
    };

    port = mkOption {
      type = types.port;
      default = 5000;
      description = "Port number dufs will listen on.";
    };

    user = mkOption {
      type = types.str;
      default = "dufs";
      description = "User to run dufs as.";
    };

    group = mkOption {
      type = types.str;
      default = "dufs";
      description = "Group to run dufs as.";
    };

    servePath = mkOption {
      type = types.path;
      default = "/var/lib/dufs";
      description = "The path to the directory to serve.";
    };

    allowAll = mkOption {
      type = types.bool;
      default = true;
      description = "Allow all operations (read, write, search). Corresponds to the -A flag.";
    };

    extraArgs = mkOption {
      type = with types; listOf str;
      default = [ ];
      description = "Extra command line arguments passed to dufs.";
      example = [ "--enable-cors" ];
    };

    openFirewall = mkOption {
      type = types.bool;
      default = false;
      description = "Whether to open the firewall port for dufs.";
    };
  };

  config = mkIf cfg.enable {
    users.users.${cfg.user} = {
      isSystemUser = true;
      group = cfg.group;
      home = cfg.servePath; # Set home to servePath for consistency
      createHome = false; # Let tmpfiles create it
    };
    users.groups.${cfg.group} = { };

    # Ensure the serve path exists and has correct permissions
    systemd.tmpfiles.rules = [ "d ${cfg.servePath} 0750 ${cfg.user} ${cfg.group} - -" ];

    systemd.services.dufs = {
      description = "DUFS Service serving ${cfg.servePath}";
      after = [ "network.target" ];
      wantedBy = [ "multi-user.target" ];

      serviceConfig = {
        User = cfg.user;
        Group = cfg.group;
        Restart = "always";
        RestartSec = "10s";
        WorkingDirectory = cfg.servePath;
      };

      script = ''
        set -euo pipefail
        ${dufsCmd}
      '';
    };

    # Open the firewall port if configured
    networking.firewall.allowedTCPPorts = lib.mkIf cfg.openFirewall [ cfg.port ];
  };
}
