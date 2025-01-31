{pkgs, ...}: {
  console = {
    colors = [
      # TODO: gruvbox
    ];

    earlySetup = true;
    font = "Hasklug Nerd Font Mono";
    packages = with pkgs; [
      nerd-fonts.hasklug
      nerd-fonts.symbols-only
      noto-fonts-emoji
    ];
  };
}
