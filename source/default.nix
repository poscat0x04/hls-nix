let
  bootstrap = import <nixpkgs> { };
  inherit (bootstrap) fetchFromGitHub;
  loadJSON = f: fetchFromGitHub (builtins.fromJSON (builtins.readFile f));
  sources = rec {
    "hls-0.1" = ./spec/hls-0.1.json; 
    hls = sources."hls-0.1";
    hls-master = ./spec/hls-master.json;
    haskell-nix = ./spec/haskell-nix.json;
  };
in builtins.mapAttrs (_: loadJSON) sources
