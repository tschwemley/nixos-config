{self, ...}: {
  programs.hyprland.enable = true;
  environment.systemPackges = [self.packages.hyprbars];
}
