let
  bootstrap = import <nixpkgs> { };
  inherit (bootstrap) fetchFromGitHub;
  loadJSON = f: fetchFromGitHub (builtins.fromJSON (builtins.readFile f));
in
  {
    haskell-nix = loadJSON ./spec/haskell-nix.json;
    lookup = tag: loadJSON (./spec + "/hls-${tag}.json");
  }
