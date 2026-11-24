{ pkgs, ... }:
{
  # ── Optional: handy tools for testing ────────────────────────────────
  environment.systemPackages = with pkgs; [
    evtest # evtest /dev/input/eventN  → see every button + paddle
    jstest-gtk # visual axis/button calibration
  ];

  # ── Bluetooth (needed only for wireless) ─────────────────────────────
  hardware = {
    bluetooth.settings.General = {
      # Fixes the classic Xbox "connect / disconnect loop" on Linux
      Privacy = "device";
      JustWorksRepairing = "always";
      FastConnectable = "true";
    };

    # ── Non-root access to gamepads (/dev/input/js*, hidraw) ─────────────
    steam-hardware.enable = true; # upstream steam-devices udev rules

    # ── Driver for Xbox One / Series / Elite over Bluetooth ──────────────
    xpadneo = {
      enable = true;

      # Optional: reduce rumble so it doesn't rattle the desk
      # rumbleAttenuation.overall = 50;
      # settings.disable_deadzones = 1;        # useful for Elite sticks
      # settings.trigger_rumble_mode = 2;
    };
  };
}
