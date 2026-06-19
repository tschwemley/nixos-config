# Contains -gatewaynixos and home-manager options and programs that I'm trialing before committing to
{
  self,
  config,
  pkgs,
  ...
}:
{
  #######################################################
  ##                                                   ##
  ##  TODO: Testing section below... remove when done  ##
  ##                                                   ##
  #######################################################
  imports = [
    #   ../../services/openclaw-gateway.nix
  ];

  ## PACKAGES ##
  environment.systemPackages = with pkgs; [
    # ayugram-desktop
    shiori

    # TODO: move the below into home-manager and figure out where the fuck to categorize
    diffoscopeMinimal
  ];

  nix.sshServe = {
    enable = true;
    keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICE7nVBYw5vQIHeNq+f7qvItDrGPjLdgs/aIo6x6ViiZ schwem@pikachu"
    ];
  };

  ## PROGRAMS ##
  programs.nix-ld.enable = true;

  ## SERVICES ##
  services.shiori.enable = true;

  services.ollama = {
    enable = true;
  };

  services.open-webui = {
    enable = true;
    port = 8180;
  };

  # services.n8n.enable = true;
  # stoat.enable = true;
  # services.torrentstream.enable = true;

  # sops.secrets."openclaw.json" = {
  #   format = "json";
  #   key = "";
  #   owner = "openclaw";
  #   group = "openclaw";
  #   sopsFile = self.lib.secret "nixos" "openclaw.json";
  # };

  ## HOME MANAGER ##
  home-manager.users.schwem = {
    programs.ghostty = {
      enable = true;
      enableZshIntegration = true;
      installBatSyntax = true;
      installVimSyntax = true;
    };

    # programs.obs-studio.enable = true;

    programs.yt-dlp = {
      enable = true;

      package =
        with pkgs.python313Packages;
        yt-dlp.overridePythonAttrs (prev: {
          dependencies = prev.dependencies ++ [ beautifulsoup4 ];
        });
    };

    programs.zsh.shellAliases."yt-dlp" = "yt-dlp --cookies-from-browser firefox:~/.config/zen/default";

    # TODO: remove unused/move keeping items elsewhere
    home.packages = with pkgs; [
      drawio
      nicotine-plus
      super-productivity
    ];
  };
}
