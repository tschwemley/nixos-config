{...}: {
  flake.templates.default = {
    path = ./go.nix;
    description = "Basic go application";
  };
}
