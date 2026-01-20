{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    qmk
    qmk_hid

    # open source gui and qmk fork -- udev built along with package
    vial
  ];

  hardware.keyboard.qmk.enable = true;
  programs.chrysalis.enable = true;
}
