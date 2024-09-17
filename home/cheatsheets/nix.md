# Nix Cheatsheet

## nixpkgs

### Overriding Package Attributes

The function `overrideAttrs` allows overriding the attribute set passed to a stdenv.mkDerivation call, producing a new derivation based on the original one.

```nix
{
  helloBar = pkgs.hello.overrideAttrs (finalAttrs: previousAttrs: {
    pname = previousAttrs.pname + "-bar";
    src = fetchFromGithub { ... };
    ...
  });
}
```
