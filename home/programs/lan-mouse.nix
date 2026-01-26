{ self, ... }:
{
  imports = [ self.inputs.lan-mouse.homeManagerModules.default ];

  programs.lan-mouse.enable = true;

  xdg.configFile."lan-mouse/config.toml".text = /* toml */ ''
    # configure release bind
    # release_bind = [ "KeyA", "KeyS", "KeyD", "KeyF" ]

    # optional port (defaults to 4242)
    port = 4242

    # define a client on the right side with host name "iridium"
    [[clients]]
    activate_on_startup = true
    hostname = "192.168.1.103"
    ips = ["192.168.1.103"]

    # position (left | right | top | bottom)
    position = "right"
  '';
}
