{...}: {
  flake.templates = {
    go = {
      path = ./go;
      description = "Basic go application";
    };
  };
}
