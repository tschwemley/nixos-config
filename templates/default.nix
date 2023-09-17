{...}: {
  flake.templates = {
    go = {
      path = ./go.nix;
      description = "Basic go application";
    };
  };
}
