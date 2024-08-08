# {
#   appimageTools,
#   fetchurl,
#   glib,
#   glib-networking,
# gtk3,
#   gst_all_1,
#   webkitgtk,
# # wxGTK31,
# }: 
pkgs: pkgs.appimageTools.wrapType2 {
  name = "bambu-studio";
  src = pkgs.fetchurl {
    # url = "https://github.com/bambulab/BambuStudio/releases/download/v01.08.04.51/BambuStudio_linux_ubuntu_v01.08.04.51_20240117.AppImage";
    # hash = "sha256-aeRKOXzIwKlYMkmpWCmGmna22G/gVhDIiacZRXbgpM4=";
    url = "https://github.com/bambulab/BambuStudio/releases/download/v01.09.03.50/Bambu_Studio_linux_ubuntu_24.04_v01.09.03.50.AppImage";
    hash = "sha256-fLLsUCiNUCVSq5c4JBr3v1duPyLLzweqlBME9khwv+E=";
  };
  extraPkgs = pkgs:
  with pkgs; [
    glib
    glib-networking
    gtk3
    gst_all_1.gst-plugins-bad
    webkitgtk
    # wxGTK31
  ];
}
