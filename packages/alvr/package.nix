{pkgs, ...}: let
  # version = "20.8.1";
  src = builtins.fetchTarball {
    # url = "https://github.com/alvr-org/ALVR/releases/download/v${version}/alvr_streamer_linux.tar.gz";
    # sha256 = "sha256:1xh7nhbng6mfsrskxk2k2443464vvwgilggywj293qfagh92kd7i";
    url = "https://github.com/alvr-org/ALVR-nightly/releases/download/v21.0.0-dev00%2Bnightly.2024.05.05/alvr_streamer_linux.tar.gz";
    sha256 = "sha256:03620kmfwhva69qa81pf6fp4n23ipcc51c3cbqkhm1n6gljdhr10";
  };
in
  pkgs.buildFHSEnv {
    name = "alvr_dashboard";
    targetPkgs = pkgs:
      with pkgs; [
        alsa-lib
        brotli
        bzip2
        ffmpeg
        jack2
        lame
        xorg.libX11
        xorg.libXrandr
        libdrm
        libogg
        libpng
        libtheora
        libunwind
        libva
        libvdpau
        libglvnd
        openssl
        pipewire
        soxr
        vulkan-headers
        vulkan-loader
        xvidcore
        # libva
        libxkbcommon
        wayland
        kdePackages.wayqt
        # wayland-scanner
        # kdePackages.wayland
        # xwayland-run
        # egl-wayland
        # eglexternalplatform
        # sbclPackages.cl-opengl
      ];
    extraInstallCommands = ''
      cp -Pr ${src}/{lib64,libexec,licenses,share} $out
      cp $out/bin/alvr_dashboard $out/bin/alvr
    '';
    runScript = ''
      ${src}/bin/alvr_dashboard
    '';
  }
