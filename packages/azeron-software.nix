{
  alsa-lib,
  appimageTools,
  dfu-util,
  fetchurl,
  fontconfig,
  gtk3,
  hidapi,
  lib,
  libusb1,
  makeDesktopItem,
  nss,
  python3,
  stdenv,
  teensy-loader-cli,
  udevCheckHook,
  usbutils,
}:
let
  pname = "azeron-software";
  version = "1.5.6";

  src = fetchurl {
    url = "https://github.com/renatoi/azeron-linux/releases/download/v${version}/${pname}-${version}-x86_64.AppImage";
    hash = "sha256-Tbak5g+fCVFvKaUT9k4I+2ym+2Z7qKtkGaygT9HudTk=";
  };

  desktopItem = makeDesktopItem {
    name = pname;
    exec = pname;
    icon = pname;
    desktopName = "Azeron Software";
    comment = "Configuration tool for Azeron keypads";
    categories = [
      "Utility"
      "HardwareSettings"
    ];
    terminal = false;
  };

  appimageContents = appimageTools.extract {
    inherit pname version src;
    postExtract = ''
      install -Dm755 \
        ${lib.getExe teensy-loader-cli} \
        $out/firmware/teensy_loader_cli

      install -Dm755 \
        ${dfu-util}/bin/dfu-util \
        $out/firmware/dfu-util
    '';
  };
in
appimageTools.wrapAppImage rec {
  inherit pname version;

  src = appimageContents;

  nativeBuildInputs = [ udevCheckHook ];

  doInstallCheck = true;

  extraPkgs = pkgs: [
    alsa-lib
    fontconfig
    gtk3
    hidapi
    libusb1
    nss
    python3
    teensy-loader-cli
    usbutils
  ];

  extraInstallCommands = ''
    # install -Dm755 \
    #   ${lib.getExe teensy-loader-cli} \
    #   $out/firmware/teensy_loader_cli

    install -Dm644 \
      ${desktopItem}/share/applications/${pname}.desktop \
      $out/share/applications/${pname}.desktop

    # Use the application icon from the extracted AppImage when available.
    for icon in \
      ${appimageContents}/usr/share/icons/hicolor/*/apps/${pname}.png \
      ${appimageContents}/usr/share/icons/hicolor/*/apps/${pname}.ico \
      ${appimageContents}/.DirIcon
    do
      if [ -f "$icon" ]; then
        install -Dm644 "$icon" \
          "$out/share/icons/hicolor/256x256/apps/${pname}.png"
        break
      fi
    done

    # # Azeron udev rules.
    # install -Dm644 /dev/stdin \
    #   "$out/lib/udev/rules.d/99-azeron.rules" <<'EOF'
    # # Azeron Keypad udev rules
    # # Allow non-root access to Azeron HID devices.
    # SUBSYSTEM=="hidraw", ATTRS{idVendor}=="16d0", MODE="0666"
    # SUBSYSTEM=="usb", ATTRS{idVendor}=="16d0", MODE="0666"
    #
    # # Register the Azeron Cyborg II XInput interface with xpad.
    # # This allows xpad to drain the endpoint and expose /dev/input/js*.
    # ACTION=="add", SUBSYSTEM=="usb", \
    #   ATTRS{idVendor}=="16d0", ATTRS{idProduct}=="0f3f", \
    #   TEST=="/sys/bus/usb/drivers/xpad/new_id", \
    #   RUN+="${stdenv.shell} -c 'echo 16d0 0f3f > /sys/bus/usb/drivers/xpad/new_id || true'"
    #
    # # STM32 DFU bootloader used for firmware updates.
    # SUBSYSTEM=="usb", ATTRS{idVendor}=="0483", \
    #   ATTRS{idProduct}=="df11", MODE="0666"
    # EOF
  '';

  # postInstall = ''
  #   ln -s $out/firmware/teensy-loader-cli $out/firmware/teensy_loader_cli
  # '';

  passthru.src = src;

  meta = {
    description = "Configuration tool for Azeron keypads";
    homepage = "https://github.com/renatoi/azeron-linux";
    license = lib.licenses.unfree;
    maintainers = [ ];
    platforms = [ "x86_64-linux" ];
    sourceProvenance = with lib.sourceTypes; [ binaryNativeCode ];
    mainProgram = pname;
  };
}
