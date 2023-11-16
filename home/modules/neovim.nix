{ ... }:

{
	programs.neovim = {
		enable = true;
		extraLuaPackages = [];
		withNodeJs = true;
		withPython3 = true;
		vimAlias = true;
		vimdiffAlias = true;
	};
}
