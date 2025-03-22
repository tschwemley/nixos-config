{pkgs, ...}: let
  packages = with pkgs; [
    chrysalis
    qmk
    # open source gui and qmk fork -- udev built along with package
    vial
  ];
in {
  environment.systemPackages = packages;
  hardware.keyboard.qmk.enable = true;

  # TODO: I want to test this to see if necessary to include when using nixpkgs provided package
  # that contains udev rules -- IF SO: UNCOMMENT
  # services.udev.packages = with pkgs; [
  #   chrysalis
  #   qmk
  #   vial
  # ];

  # add req. udev rules so non-root can make changes
  # services.udev.packages = [pkgs.chrysalis];
}
