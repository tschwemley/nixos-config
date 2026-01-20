{ pkgs, ... }:
{
  hardware.onlykey.enable = true;

  environment.systemPackages = with pkgs; [
    onlykey
    onlykey-cli
    onlykey-agent
  ];
}
