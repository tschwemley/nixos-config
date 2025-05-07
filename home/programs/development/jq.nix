{
  programs = {
    jq = {
      enable = true;
      colors = {
        null = "1;38;5;223";
        false = "0;38;5;223";
        true = "0;38;5;223";
        numbers = "0;38;5;223";
        strings = "0;38;5;142";
        arrays = "1;38;5;142";
        objects = "1;38;5;142";
        objectKeys = "0;38;5;214";
      };
    };

    jqp = {
      enable = true;
      settings.theme.name = "gruvbox";
    };
  };
}
