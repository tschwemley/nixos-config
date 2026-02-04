{
  lib,
  pkgs,
  output,
}:
{
  fonts.fontconfig.subpixel.rgba = lib.mkDefault "bgr";
  # fonts.fontconfig.subpixel.rgba = lib.mkDefault "vbgr";

  hardware = {
    display = {
      edid = {
        enable = true;

        # linuxhw."SAM72C3_2022" = [ "SAM72C3" ];
        # linuxhw."SAM72C8_2022" = [
        #   "SAM72C8"
        #   "2022"
        # ];

        packages = [
          (pkgs.runCommand "edid-ark" { } ''
            mkdir -p $out/lib/firmware/edid
            base64 -d > "$out/lib/firmware/edid/ark.bin" <<'EOF'
            AP///////wBMLR3gAAAAAAEhAQS1eUR4O8AVrU9GqicNUFQhiACBwIEAgYCVAKnAswABAQEBodYA5vBwWoAwIDoAuqhCAAAaAAAA/QwwpYODqgEKICAgICAgAAAA/ABPZHlzc2V5IEFyawogAAAA/wBIMUFLNTAwMDAwCiAgAokCAzPwR2EQPwQDX3YjCQcHgwEAAOMFwABtGgAAAg8wpQAEiwJzDOYGBQGLcwPlAYuEkHlWXgCgoKApUDAgNQC6qEIAABoDxwDgoKBVUFAgNQC6qEIAABqknICgcDhZQDAgNQC6qEIAABoAAAAAAAAAAAAAAAAAAAAAAAAAAAAAC3ASeQMAAwEoCZcChP8OLwL3gB8AbwixAAIABAC9FwEE/wnfAE+AHwCfBXYAAgAEAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAFCQ
            EOF
          '')
        ];
      };

      outputs.${output} = {
        edid = "ark.bin";
        # edid = "SAM72C8_2022.bin";

        mode = "e";
      };
    };
  };
}
