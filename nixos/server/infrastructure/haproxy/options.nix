# TODO: when writing reference: https://docs.haproxy.org/2.4/configuration.html#4.1
{lib, ...}:
with lib; let
  modeOpt = mkOption {
    type = types.strMatching "tcp|http";
    default = "";
    description = "see: https://docs.haproxy.org/2.4/configuration.html#4-mode";
  };

  timeoutOpts = {
    check = mkOption {
      type = types.str;
      default = "";
      description = "Set additional check timeout, but only after a connection has been already established.\n\nSee: https://docs.haproxy.org/2.4/configuration.html#4-timeout%20check";
    };

    client = mkOption {
      type = types.str;
      default = "";
      description = "Set the maximum inactivity time on the client side.\n\nSee: https://docs.haproxy.org/2.4/configuration.html#4-timeout%20client";
    };

    client-fin = mkOption {
      type = types.str;
      default = "";
      description = "Set the inactivity timeout on the client side for half-closed connections.\n\nSee: https://docs.haproxy.org/2.4/configuration.html#4-timeout%20client-fin";
    };

    connect = mkOption {
      type = types.str;
      default = "";
      description = "Set the maximum time to wait for a connection attempt to a server to succeed.\n\nSee: https://docs.haproxy.org/2.4/configuration.html#4-timeout%20connect";
    };

    http-keep-alive = mkOption {
      type = types.str;
      default = "";
      description = "Set the maximum allowed time to wait for a new HTTP request to appear.\n\nSee: https://docs.haproxy.org/2.4/configuration.html#4-timeout%20http-keep-alive";
    };

    http-request = mkOption {
      type = types.str;
      default = "";
      description = "Set the maximum allowed time to wait for a complete HTTP request.\n\nSee: https://docs.haproxy.org/2.4/configuration.html#4-timeout%20http-request";
    };

    queue = mkOption {
      type = types.str;
      default = "";
      description = "Set the maximum time to wait in the queue for a connection slot to be free.\n\nSee: https://docs.haproxy.org/2.4/configuration.html#4-timeout%20queue";
    };

    server = mkOption {
      type = types.str;
      default = "";
      description = "Set the maximum inactivity time on the server side.\n\nSee: https://docs.haproxy.org/2.4/configuration.html#4-timeout%20server";
    };

    server-fin = mkOption {
      type = types.str;
      default = "";
      description = "Set the inactivity timeout on the server side for half-closed connections.\n\nSee: https://docs.haproxy.org/2.4/configuration.html#4-timeout%20server-fin";
    };

    tarpit = mkOption {
      type = types.str;
      default = "";
      description = "Set the duration for which tarpitted connections will be maintained.\n\nSee: https://docs.haproxy.org/2.4/configuration.html#4-timeout%20tarpit";
    };

    tunnel = mkOption {
      type = types.str;
      default = "";
      description = "Set the maximum inactivity time on the client and server side for tunnels.\n\nSee: https://docs.haproxy.org/2.4/configuration.html#4-timeout%20tunnel";
    };
  };
in {
  options.haproxy = with lib; {
    defaults = {
      log = mkOption {
        type = types.listOf types.str;
        default = [];
        description = "see: https://docs.haproxy.org/2.4/configuration.html#4-log";
      };

      mode = modeOpt;

      timeout = timeoutOpts;
    };

    listen = {
      bind = mkOption {
        type = types.listOf types.str;
        default = [];
        description = "see: https://docs.haproxy.org/2.4/configuration.html#4-bind";
      };

      mode = modeOpt;

      timeout = timeoutOpts;
    };
  };
}
