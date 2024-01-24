{pkgs, ...}: {
  home.packages = with pkgs; [
    silly-tavern
  ];
  # xdg.desktopEntries.bambuStudio = {
  #   categories = ["Graphics" "3DGraphics" "Engineering"];
  #   exec = "bambu-studio %F";
  #   genericName = "3D Printing Software";
  #   icon = "BambuStudio";
  #   mimeType = [
  #     "model/stl"
  #     "application/vnd.ms-3mfdocument"
  #     "application/prs.wavefront-obj"
  #     "application/x-amf"
  #   ];
  #   name = "Bambu Studio";
  #   startupNotify = false;
  #   terminal = false;
  #   type = "Application";
  # };
}
