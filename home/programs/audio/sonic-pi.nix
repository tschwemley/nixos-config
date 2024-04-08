{
  jackWrap,
  pkgs,
  ...
}: {
  home.packages = [(jackWrap pkgs.sonic-pi)];
}
