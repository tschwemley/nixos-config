{ self, config, ... }:
{
  imports = [ self.inputs.lan-mouse.homeManagerModules.default ];

  programs.lan-mouse.enable = true;

  sops = {
    secrets =
      let
        key = "lan_mouse_certificate_fingerprint";
      in
      {
        lan-mouse-cert-fingerprint-charizard = {
          inherit key;
          sopsFile = ../../nixos/hosts/charizard/secrets.yaml;
        };

        lan-mouse-cert-fingerprint-pikachu = {
          inherit key;
          sopsFile = ../../nixos/hosts/pikachu/secrets.yaml;
        };
      };

    templates."lan-mouse-config.toml" = {
      path = "${config.xdg.configHome}/lan-mouse/config.toml";
      content = /* toml */ ''
        # configure release bind
        # release_bind = [ "KeyA", "KeyS", "KeyD", "KeyF" ]

        # optional port (defaults to 4242)
        port = 4242

        # define a client on the right side with host name "iridium"
        [[clients]]
        activate_on_startup = false
        hostname = "192.168.1.103"
        ips = ["192.168.1.103"]

        [[clients]]
        activate_on_startup = false
        hostname = "charizard"

        [[clients]]
        activate_on_startup = false
        hostname = "pikachu"

        # position (left | right | top | bottom)
        position = "right"

        [authorized_fingerprints]
        "${config.sops.placeholder.lan-mouse-cert-fingerprint-charizard}" = "charizard"
        "${config.sops.placeholder.lan-mouse-cert-fingerprint-pikachu}" = "pikachu"
      '';
    };
  };
}
