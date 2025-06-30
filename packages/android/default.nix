{pkgs, ...}: {
  default = pkgs.androidenv.emulateApp {
    # TODO: change this name
    name = "android-default-emu";
    platformVersion = "28";
    abiVersion = "x86"; # armeabi-v7a, mips, x86_64
    systemImageType = "google_apis_playstore";
  };
}
