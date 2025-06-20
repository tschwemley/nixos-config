{pkgs, ...}: {
  imports = [
    ./.
    ../programs/ai
    ../programs/browsers
    ../programs/communication
    ../programs/creative
    ../programs/development/bruno.nix
    ../programs/development/databases.nix
    ../programs/development/nix.nix
    ../programs/gnome
    ../programs/media
    ../programs/music
    ../programs/productivity

    ../programs/neovide.nix

    ../programs/bitwarden.nix
    ../programs/cowsay.nix
    ../programs/glow.nix
    # ../programs/input-leap.nix
    ../programs/lan-mouse.nix
    ../programs/nemo.nix
    ../programs/qt.nix
    ../programs/taskwarrior.nix
    ../programs/wayland/hyprland
    ../programs/wcalc.nix
    ../programs/webcamoid.nix
    ../programs/wofi.nix

    ../services/kdeconnect.nix
    ../services/mpris-proxy.nix

    ../theme

    ../xdg
    ../xdg/netrc.nix
    ../xdg/ssh/personal.nix

    # TODO: go through and decide which to keep and which to remove
    # ../programs/cad.nix
  ];

  home = {
    homeDirectory = "/home/schwem";
    username = "schwem";

    # TODO: move elsewhere
    packages = with pkgs; [nicotine-plus];

    sessionVariables = {
      VISUAL = "nvim";
    };
  };

  # pc specific program config
  programs = {
    git.extraConfig.url = {
      "ssh://gh" = {
        insteadOf = "https://github.com";
      };
    };
  };
}
