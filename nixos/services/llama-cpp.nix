{ self, pkgs, ... }:
let
  inherit (self.inputs.nixpkgs-master.legacyPackages.${pkgs.stdenv.hostPlatform.system}) llama-cpp-rocm;
in
{
  environment.systemPackages = [ llama-cpp-rocm ];

  services.llama-cpp = {
    enable = true;
    package = llama-cpp-rocm;
    port = 4141;

    # TODO: fix this hard-coded path and (probably) pass as arg
    model = "/home/schwem/projects/ai/models/llm/Qwen3-Coder-30B-A3B-Instruct-UD-Q8_K_XL.5YkhQ0l3.gguf";
  };
}
