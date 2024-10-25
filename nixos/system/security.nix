{
  security = {
    # enable esync compatability (for Lutris)
    pam = {
      loginLimits = [
        {
          domain = "*";
          item = "nofile";
          type = "-";
          value = "524288";
        }
      ];
      services.hyprlock = { };
    };
    polkit.enable = true;
    sudo.wheelNeedsPassword = false;
  };

  systemd.extraConfig = "DefaultLimitNOFILE=524288";
  systemd.user.extraConfig = "LimitNOFILE=524288";
}
