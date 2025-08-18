{ self, ... }:
{
  sops.secrets."neovim.env" = {
    key = "";
    format = "dotenv";
    mode = "0440";
    sopsFile = "${self}/secrets/home/neovim.env";
  };
}
