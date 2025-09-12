{
  self,
  pkgs,
  ...
}:
{
  programs.neovim = {
    extraPackages = with pkgs; [
      basedpyright

      lua-language-server

      nixd

      nodePackages.intelephense

      superhtml
      vscode-css-languageserver
    ];

    plugins = with pkgs.vimPlugins; [
      nvim-lspconfig
    ];
  };

  # sops.secrets =
  #   let
  #     mkSecret = key: {
  #       inherit key;
  #       sopsFile = "${self}/secrets/home/neovim.yaml";
  #     };
  #
  #   in
  #   {
  #     intelephense_license = mkSecret "intelephense_license";
  #     openrouter_nvim_api_key = mkSecret "openrouter_api_key";
  #   };
}
