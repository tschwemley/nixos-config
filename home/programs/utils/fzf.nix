{
  programs.fzf = {
    enable = true;

    colors = {
      bg = "#1D2021"; # background
      fg = "#D4BE98"; # foreground

      # Selection/UI colors
      "bg+" = "#3C3836"; # selection_bg contrast (derived from selection_fg)
      "fg+" = "#D4BE98"; # foreground remains consistent
      hl = "#EA6962"; # red (ansi[1])
      "hl+" = "#EA6962"; # red (brights[1])

      # Accents
      info = "#7DAEA3"; # blue (ansi[4])
      prompt = "#A9B665"; # green (ansi[2])
      spinner = "#D8A657"; # yellow (ansi[3])
      pointer = "#D3869B"; # purple (ansi[5])
      marker = "#D3869B"; # purple (ansi[5])
      header = "#EA6962"; # red (ansi[1])
    };
  };
}
