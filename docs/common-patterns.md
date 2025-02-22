## Adding a directory to $PATH

For example adding Elixir install scripts into `~/.mix/escripts`

```nix
{ ... }:

{
  languages.elixir.enable = true;

  enterShell = ''
    export PATH="$HOME/.mix/escripts:$PATH"
  '';
}
```

## How Can I use Rosetta packages?

It's possible to tell Nix to use Intel packages when we're using macOS ARM:

```nix
{ pkgs, ... }:

let
  rosettaPkgs = 
    if pkgs.stdenv.isDarwin && pkgs.stdenv.isAarch64
    then pkgs.pkgsx86_64Darwin
    else pkgs;
in {
  packages = [
    pkgs.git
    rosettaPkgs.vim
  ];
}
```
