{...}: {
  perSystem = {
    pkgs,
    lib,
    ...
  }: {
    packages = {
      # llama-cpp = import ./llama-cpp.nix;

      ollama = let
        llama-cpp = pkgs.llama-cpp;
      in
        pkgs.buildGoModule rec {
          pname = "ollama";
          version = "0.1.17";

          src = pkgs.fetchFromGitHub {
            owner = "jmorganca";
            repo = "ollama";
            rev = "v${version}";
            hash = "sha256-eXukNn9Lu1hF19GEi7S7a96qktsjnmXCUp38gw+3MzY=";
          };

          patches = [
            # disable passing the deprecated gqa flag to llama-cpp-server
            # see https://github.com/ggerganov/llama.cpp/issues/2975
            # ./disable-gqa.patch

            # replace the call to the bundled llama-cpp-server with the one in the llama-cpp package
            ./set-llamacpp-path.patch
          ];

          postPatch = ''
            # substituteInPlace llm/llama.go \
            #   --subst-var-by llamaCppServer "${llama-cpp}/bin/llama-cpp-server"
            substituteInPlace llm/llama.go \
              --subst-var-by llamaCppServer "${llama-cpp}/bin/llama-server"
            substituteInPlace server/routes_test.go --replace "0.0.0" "${version}"
          '';

          vendorHash = "sha256-yGdCsTJtvdwHw21v0Ot6I8gxtccAvNzZyRu1T0vaius=";

          ldflags = [
            "-s"
            "-w"
            "-X=github.com/jmorganca/ollama/version.Version=${version}"
            "-X=github.com/jmorganca/ollama/server.mode=release"
          ];

          tags = ["opencl" "rocm"];

          meta = with lib; {
            description = "Get up and running with large language models locally";
            homepage = "https://github.com/jmorganca/ollama";
            license = licenses.mit;
            mainProgram = "ollama";
            maintainers = with maintainers; [dit7ya elohmeier];
            platforms = platforms.unix;
          };
        };

      # bambuStudio = pkgs.appimageTools.wrapType2 {
      #   name = "bambu-studio";
      #   src = pkgs.fetchurl {
      #     url = "https://github.com/bambulab/BambuStudio/releases/download/v01.08.00.57/Bambu_Studio_linux_ubuntu_v01.08.00.57-20231109141031.AppImage";
      #     hash = "sha256:0h55qvhzj537akygdwwla38c3ycpf2fxl4w2bj2ssb8g07wl5n36";
      #   };
      #   extraPkgs = pkgs:
      #     with pkgs; [
      #       glib-networking
      #       webkitgtk
      #     ];
      # };
    };
  };
}
