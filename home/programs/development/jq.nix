{
  programs = {
    jq = {
      enable = true;
      colors = {
        null = "38;2;124;111;100";
        false = "38;2;251;73;52";
        true = "38;2;184;187;38";
        numbers = "38;2;250;189;47";
        strings = "38;2;142;192;124";
        arrays = "38;2;254;128;25";
        objects = "38;2;235;219;178";
        objectKeys = "38;2;131;165;152";
      };
    };

    jqp = {
      enable = true;
      settings.theme.name = "gruvbox";
    };
  };
}
