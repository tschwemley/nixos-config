{
  pkgs,
  output,
}:
{
  fonts.fontconfig.subpixel.rgba = "bgr";

  hardware.display = {
    edid.packages = [
      (pkgs.runCommand "edid-ark" { } ''
        mkdir -p $out/lib/firmware/edid
        base64 -d > "$out/lib/firmware/edid/ark.bin" <<'EOF'
        AP///////wBMLR3gAAAAAAEhAQS1eUR4O8AVrU9GqicNUFQhiACBwIEAgYCVAKnAswABAQEBodYA5vBwWoAwIDoAuqhCAAAaAAAA/QwwpYODqgEKICAgICAgAAAA/ABPZHlzc2V5IEFyawogAAAA/wBIMUFLNTAwMDAwCiAgAokCAzPwR2EQPwQDX3YjCQcHgwEAAOMFwABtGgAAAg8wpQAEiwJzDOYGBQGLcwPlAYuEkHlWXgCgoKApUDAgNQC6qEIAABoDxwDgoKBVUFAgNQC6qEIAABqknICgcDhZQDAgNQC6qEIAABoAAAAAAAAAAAAAAAAAAAAAAAAAAAAAC3ASeQMAAwEoCZcChP8OLwL3gB8AbwixAAIABAC9FwEE/wnfAE+AHwCfBXYAAgAEAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAFCQ
        EOF
      '')
    ];

    outputs.${output}.edid = "ark.bin";
  };
}
