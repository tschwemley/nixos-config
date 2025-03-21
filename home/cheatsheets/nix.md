# Nix Cheatsheet

## flakes

### Add a file locally in git but don't include it in commits[^1]

```sh
git add --intent-to-add extra/flake.nix
git update-index --skip-worktree --assume-unchanged extra/flake.nix
```

## Flakes

### Using a non-flake repo in `flake.inputs`

```nix
{
  foo = {
    # ...
    flake = false;
  }
}
```

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

[^1]: https://wiki.nixos.org/wiki/Flakes#Development_tricks
