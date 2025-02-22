{ pkgs, config, lib, ... }:

let
  cfg = config.languages.haskell;
  # ghc.version with removed dots
  ghcVersion = lib.replaceStrings [ "." ] [ "" ] cfg.package.version;
in
{
  options.languages.haskell = {
    enable = lib.mkEnableOption "tools for Haskell development";

    package = lib.mkOption {
      type = lib.types.package;
      default = pkgs.ghc;
      defaultText = "pkgs.ghc";
      description = ''
        Haskell compiler to use.
      '';
    };

    languageServer = lib.mkOption {
      type = lib.types.nullOr lib.types.package;
      default = pkgs.haskell-language-server.override
        {
          supportedGhcVersions = [ ghcVersion ];
        };
      defaultText = "pkgs.haskell-language-server";
      description = ''
        Haskell language server to use.
      '';
    };
  };

  config = lib.mkIf cfg.enable {
    packages = with pkgs; [
      cfg.package
      cfg.languageServer
      stack
      cabal-install
      zlib
      hpack
    ];
  };
}
