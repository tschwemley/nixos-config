{...}: {
  flake.templates = {
    go = {
      path = ./go;
      description = "Basic go application";
    };
    node = {
      path = ./node;
      description = "Basic node application";
    };
    php = {
      path = ./php;
      description = "Basic php application";
    };
  };
}
