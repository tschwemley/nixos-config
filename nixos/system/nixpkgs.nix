{
  self,
  inputs,
  ...
}: {
  nixpkgs = {
    config = {
      allowUnfree = true;
      permittedInsecurePackages = [
        # "aspnetcore-runtime-6.0.36"
        # "dotnet-sdk-6.0.428"
        # "electron-31.7.7" # TODO: fix electron version
      ];
    };

    overlays = [
      (final: _: {
        inherit
          (self.packages.${final.pkgs.system})
          anonymous-overflow
          json2go
          wl-ocr
          ;

        inherit (inputs.nixpkgs-stable.legacyPackages.${final.system}) rocmPackages;

        inherit (inputs.zen-browser.packages.${final.system}) zen-browser;
        # rocmPackages =
        #   prev.rocmPackages
        #   // {
        #     llvm.libcxx = prev.rocmPackages.llvm.libcxx.overrideAttrs {
        #       postPatch = ''
        #         cd runtimes
        #         chmod +w -R ../libcxx/test/{libcxx,std}
        #         # BUG: [01-23-25] poor man's patch for https://github.com/NixOS/nixpkgs/pull/375850
        #         # TODO: remove when resolved upstream
        #         failing_tests_list=$(cat /nix/store/5zvyg0f2j8017107y0l34xwvkiqi45y2-1000-libcxx-failing-tests.list && echo "../libcxx/test/libcxx/transitive_includes.sh.cpp")
        #         echo $failing_tests_list | xargs -d rm"
        #       '';
        #     };
        #   };
      })
    ];
  };
}
