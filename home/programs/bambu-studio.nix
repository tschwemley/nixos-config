# {pkgs, ...}: let
# bambuStudio = pkgs.appimageTools.wrapType2 {
#   name = "bambu-studio";
#   src = pkgs.fetchurl {
#     # url = "https://github.com/bambulab/BambuStudio/releases/download/v01.08.00.57/Bambu_Studio_linux_ubuntu_v01.08.00.57-20231109141031.AppImage";
#     # hash = "sha256:0h55qvhzj537akygdwwla38c3ycpf2fxl4w2bj2ssb8g07wl5n36"
#     url = "https://github.com/bambulab/BambuStudio/releases/download/v01.08.04.51/BambuStudio_linux_ubuntu_v01.08.04.51_20240117.AppImage";
#     hash = "sha256-aeRKOXzIwKlYMkmpWCmGmna22G/gVhDIiacZRXbgpM4=";
#   };
#   extraPkgs = pkgs:
#     with pkgs; [
#       glib
#       glib-networking
#       gst_all_1.gst-plugins-bad
#       webkitgtk
#     ];
# };
# in {
{pkgs, ...}: {
  home.packages = with pkgs; [bambu-studio];
  #   home.packages = [bambuStudio];
  #   xdg.desktopEntries.bambuStudio = {
  #     categories = ["Graphics" "3DGraphics" "Engineering"];
  #     exec = "bambu-studio %F";
  #     genericName = "3D Printing Software";
  #     icon = "BambuStudio";
  #     mimeType = [
  #       "model/stl"
  #       "application/vnd.ms-3mfdocument"
  #       "application/prs.wavefront-obj"
  #       "application/x-amf"
  #     ];
  #     name = "Bambu Studio";
  #     startupNotify = false;
  #     terminal = false;
  #     type = "Application";
  #   };
}
