{ inputs,...}: 
let
  impermanence = import ../../modules/system/impermanence.nix {inherit inputs;};
in
{
  imports = [
    impermanence
    ./server.nix
    ../modules/services/cloudflared.nix
  ];
}
