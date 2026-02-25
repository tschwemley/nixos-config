{
  self,
  config,
  lib,
  pkgs,
  ...
}:
let
  networking = {
    imports = [
      ../../network/containers.nix
      ../../network/tailscale.nix
    ];
  };
  user = (import ../../system/users.nix { inherit self config pkgs; }).schwem;
in
{
  imports = [
    networking
    user

    ./hardware.nix
    ../../profiles/pc.nix

    # TODO: make systemd boot import from the nixos/pc profile (unless pika is an exception for some reason)
    ../../system/boot/systemd.nix

    self.inputs.stylix.nixosModules.stylix

    # TODO: move this to a profile
    # ../../services/llama-cpp.nix

    # ../../../nixos/server/communication/stoat/docker-compose.nix
  ];

  networking = {
    enableIPv6 = true;
    hostName = "charizard";
    networkmanager.enable = true;
    useDHCP = lib.mkDefault true;
  };

  # read: https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion when ready to update
  system.stateVersion = "24.05";

  #######################################################
  ##                                                   ##
  ##  TODO: Testing section below... remove when done  ##
  ##                                                   ##
  #######################################################

  ## PACKAGES ##
  environment.systemPackages = with pkgs; [
    # ayugram-desktop
    displaycal
    shiori

    # TODO: move the below into home-manager and figure out where the fuck to categorize
    diffoscopeMinimal
    pandoc
  ];

  ## PROGRAMS ##
  programs.nix-ld.enable = true;

  ## SERVICES ##
  # services.n8n.enable = true;
  services.shiori.enable = true;
  stylix = {
    enable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-material-dark-medium.yaml";
    targets = {
      fontconfig.enable = false;
      font-packages.enable = false;
      # waybar.enable = false;
    };
  };

  ## HOME MANAGER ##
  home-manager.users.schwem = {
    #
    # TODO: move elsewhere
    imports = [
      ../../../home/programs/media/gallery-dl.nix
    ];

    stylix.targets = {
      waybar.enable = false;
    };

    programs.yt-dlp = {
      enable = true;

      package =
        with pkgs.python313Packages;
        yt-dlp.overridePythonAttrs (prev: {
          dependencies = prev.dependencies ++ [ beautifulsoup4 ];
        });
    };

    programs.zsh.shellAliases."yt-dlp" =
      "yt-dlp --cookies-from-browser firefox:~/.zen/fd4lnfim.default";

    # TODO: remove unused/move keeping items elsewhere
    home.packages = with pkgs; [
      drawio
      nicotine-plus
      super-productivity
    ];
  };
}
