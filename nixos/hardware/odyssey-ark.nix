{
  lib,
  pkgs,
  ...
}:
let
  edid-odyssey-ark = pkgs.runCommand "edid-odyssey-ark" { } ''
    mkdir -p $out/lib/firmware/edid
    base64 -d > "$out/lib/firmware/edid/odyssey-ark.bin" <<'EOF'
    AP///////wBMLR3gAAAAAAEhAQS1eUR4O8AVrU9GqicNUFQhiACBwIEAgYCVAKnAswABAQEBodYA5vBwWoAwIDoAuqhCAAAaAAAA/Qx4pYODqgEKICAgICAgAAAA/ABPZHlzc2V5IEFyawogAAAA/wBIMUFLNTAwMDAwCiAgAkECAzvwR2EQPwQDX3YjCQcHgwEAAOMFwABtGgAAAg8wpQAEiwJzDOYGBQGLcwPlAYuEkHmDAAAAYwAAAFZeAKCgoClQMCA1ALqoQgAAGgPHAOCgoFVQUCA1ALqoQgAAGqScgKBwOFlAMCA1ALqoQgAAGgAAAAAAAAAAAAAAAAAAHXASeQMAAwEoCZcChP8OLwL3gB8AbwixAAIABAC9FwEE/wnfAE+AHwCfBXYAAgAEAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAFCQ
    EOF
  '';

  edid-odyssey-ark-165 = pkgs.runCommand "edid-odyssey-ark-165" { } ''
    mkdir -p $out/lib/firmware/edid
    base64 -d > "$out/lib/firmware/edid/odyssey-ark-165.bin" <<'EOF'
    AP///////wBMLR3gAAAAAAEhAQS1eUR4O8AVrU9GqicNUFQhiACBwIEAgYCVAKnAswABAQEBodYA5vBwWoAwIDoAuqhCAAAaAAAA/QykpYODqgEKICAgICAgAAAA/ABPZHlzc2V5IEFyawogAAAA/wBIMUFLNTAwMDAwCiAgAhUCAzvwR2EQPwQDX3YjCQcHgwEAAOMFwABtGgAAAg8wpQAEiwJzDOYGBQGLcwPlAYuEkHmDAAAAYwAAAFZeAKCgoClQMCA1ALqoQgAAGgPHAOCgoFVQUCA1ALqoQgAAGqScgKBwOFlAMCA1ALqoQgAAGgAAAAAAAAAAAAAAAAAAHXASeQMAAwEoCZcChP8OLwL3gB8AbwixAAIABAC9FwEE/wnfAE+AHwCfBXYAAgAEAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAFCQ
    EOF
  '';

  edid-odyssey-ark-timing-calc = pkgs.runCommand "edid-odyssey-ark-timing-calc" { } ''
    mkdir -p $out/lib/firmware/edid
    base64 -d > "$out/lib/firmware/edid/odyssey-ark-timing-calc.bin" <<'EOF'
    AP///////wBMLR3gAAAAAAEhAQS1eUR4O8AVrU9GqicNUFQhiACBwIEAgYCVAKnAswABAQEBodYA5vBwWoAwIDoAuqhCAAAaAAAA/QwwpYODqgEKICAgICAgAAAA/ABPZHlzc2V5IEFyawogAAAA/wBIMUFLNTAwMDAwCiAgAokCAzPwR2EQPwQDX3YjCQcHgwEAAOMFwABtGgAAAg8wpQAEiwJzDOYGBQGLcwPlAYuEkHlWXgCgoKApUDAgNQC6qEIAABoDxwDgoKBVUFAgNQC6qEIAABqknICgcDhZQDAgNQC6qEIAABoAAAAAAAAAAAAAAAAAAAAAAAAAAAAAC3ASeQMAAwEoCZcChP8OLwL3gB8AbwixAAIABABAIwKE/w5PAAeAHwBvCLEAowAHAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAGGQ
    EOF
  '';

  edid-lg-dual-up = pkgs.runCommand "edid-lg-dual-up" { } ''
    mkdir -p $out/lib/firmware/edid
    base64 -d > "$out/lib/firmware/edid/lg-dual-up.bin" <<'EOF'
    AP///////wAebfRbkMMGAAIhAQOALzR46iQFr09CqyUPUFQhCADRwGFARUABAQEBAQEBAQEBmNAAQKFA1LAwIDoA0QsSAAAaAAAA/QA7PR6yMQAKICAgICAgAAAA/ABMRyBTRFFIRAogICAgAAAA/wAzMDJOVEFCRDEyODAKATICA0JyIwkHB00BAwSQEhMfIl1eX2BhgwEAAG0DDAAgALg8IABgAQIDZ9hdxAF4gAPjDwAY4gBq4wXAAOYGBQFSUlERXQCgoEApsDAgOgDRCxIAABoAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAsw==
    EOF
  '';
in
{
  # boot.kernelParams = [
  #   # "video=DP-1:3840x2160@165m"
  #   "video=HDMI-A-1:3840x2160@165m"
  #   "amdgpu.ppfeaturemask=0xffffffff" # Unlocks full OC/voltage control forLACT
  # ];

  fonts.fontconfig.subpixel = {
    rgba = lib.mkDefault "bgr";
    lcdfilter = "default";
  };
  # fonts.fontconfig.subpixel.rgba = lib.mkDefault "vbgr";

  hardware = {
    display = {
      edid = {
        enable = true;

        packages = [
          edid-lg-dual-up
          edid-odyssey-ark
          edid-odyssey-ark-165
          edid-odyssey-ark-timing-calc
        ];

      };

      outputs = {
        "DP-1" = {
          # edid = "odyssey-ark.bin";
          # edid = "odyssey-ark-165.bin";
          edid = "odyssey-ark-timing-calc.bin";
          mode = "e";
        };

        # "HDMI-A-1" = {
        #   edid = "odyssey-ark.bin";
        #   mode = "e";
        # };
      };
    };
  };

  # If the udev rule applies too late, you can use a systemd one-shot service:
  # systemd.services.force-gpu-performance = {
  #   description = "Force GPU to high performance mode to fix monitor scan lines";
  #   wantedBy = [ "multi-user.target" ];
  #   serviceConfig = {
  #     Type = "oneshot";
  #     ExecStart = ''
  #       ${pkgs.bash}/bin/bash -c 'echo high > /sys/class/drm/card1/device/power_dpm_force_performance_level'
  #     '';
  #   };
  # };
}
