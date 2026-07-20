{
  lib,
  stdenv,
  fetchurl,
  appimageTools,
  makeDesktopItem,
  alsa-lib,
  gtk3,
  hidapi,
  libusb1,
  nss,
  python3,
  usbutils,
}:

let
  pname = "azeron-software";
  version = "1.5.6";

  src = fetchurl {
    url = "https://github.com/renatoi/azeron-linux/releases/download/v${version}/${pname}-${version}-x86_64.AppImage";
    hash = "sha256-85RJJ8eFqTVjl4f7rd3ctM+cBUSoGDLFrftpRFgjcaQ=";
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

  appimageContents = appimageTools.extractType2 {
    inherit pname version src;
  };
in
appimageTools.wrapType2 rec {
  inherit pname version src;

  extraPkgs = pkgs: [
    alsa-lib
    gtk3
    hidapi
    libusb1
    nss
    python3
    usbutils
  ];

  extraInstallCommands = ''
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

    # Azeron HID and STM32 DFU permissions.
    install -Dm644 /dev/stdin \
      $out/lib/udev/rules.d/99-azeron.rules <<'EOF'
    # Azeron Keypad udev rules
    # Vendor ID 16d0 is used by Azeron devices.
    SUBSYSTEM=="hidraw", ATTRS{idVendor}=="16d0", MODE="0666"
    SUBSYSTEM=="usb", ATTRS{idVendor}=="16d0", MODE="0666"

    # Register the Azeron XInput interface with xpad.
    ACTION=="add", SUBSYSTEM=="usb", ATTRS{idVendor}=="16d0", ATTRS{idProduct}=="12f7", TEST=="/sys/bus/usb/drivers/xpad/new_id", RUN+="/bin/sh -c 'echo 16d0 12f7 > /sys/bus/usb/drivers/xpad/new_id || true'"

    # STM32 DFU bootloader used for firmware updates.
    SUBSYSTEM=="usb", ATTRS{idVendor}=="0483", ATTRS{idProduct}=="df11", MODE="0666"
    EOF
  '';

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

# {
#   appimageTools,
#   fetchurl,
#   makeDesktopItem,
# }:
#
# let
#   pname = "example";
#   version = "1.0.0";
#
#   src = fetchurl {
#     url = "https://github.com/renatoi/azeron-linux/releases/download/v${version}/azeron-software-${version}-x86_64.AppImage";
#     sha256 = "sha256-i7mXDndTp0pr6COiRlu3y/I1y7Wm9BI/HupCy3redbc=";
#   };
#
#   appimageContents = appimageTools.extractType2 {
#     inherit
#       pname
#       version
#       src
#       ;
#   };
# in
# appimageTools.wrapType2 {
#   inherit pname version src;
#
#   extraInstallCommands = ''
#       mv $out/bin/${pname}-${version} $out/bin/${pname}
#     install -Dm444 ${appimageContents}/app.desktop
#       $out/share/applications/${pname}.desktop
#       install -Dm444 ${appimageContents}/app.png
#       $out/share/icons/hicolor/256x256/apps/${pname}.png
#       substituteInPlace $out/share/applications/${pname}.desktop \
#       --replace 'Exec=app' 'Exec=${pname}'
#   '';
# }
