{pkgs, ...}: {
  programs.neovim = {
    extraPackages = with pkgs; [
      # lsp and linters
      golangci-lint
      gopls
      templ

      # binaries used by go.nvim
      gofumpt
      golines
      gomodifytags
      impl
      reftools # contains fillstruct, fillswitch, and fixplurals
    ];
  };
}
