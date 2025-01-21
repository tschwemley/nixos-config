lib:
lib
// {
  mkStrOption = attrs: lib.mkOption ({type = lib.types.str;} // attrs);

  # define secret paths as constants for convenience
  secrets = {
    home = ./secrets/home;
    nixos = ./secrets/nixos;
    server = ./secrets/server;
  };

  stringList = lib.types.listOf lib.types.str;
}
