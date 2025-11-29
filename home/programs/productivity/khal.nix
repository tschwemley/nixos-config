{
  programs.khal = {
    enable = true;
    settings = {
      personal = {
        path = "~/.calendars/personal";
      };

      work = {
        path = "~/.calendars/work";
        readonly = true;
      };
    };
  };
}
