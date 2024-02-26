# Declarative vs Imperative containers
NOTE: I could definine the containers this way, but it results in declarative containers
(meaning all the containers get updated as the flake gets updated. Using a conf file per
container and declaring imperatively gives more granular control over each containers'
versioning

```nix
flake.nixosConfigurations = {
  searxng = inputs.nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    modules = [
      {
        boot.isContainer = true;
        imports = [
          inputs.sops.nixosModules.sops
          ./nixos/searxng
        ];
        sops.age.keyFile = /root/.config/sops/age/keys.txt;
        system.stateVersion = "23.11";
      }
    ];
  };
};
```
