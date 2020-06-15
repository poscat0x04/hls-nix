{ source ? import ./source }:
let
  haskellNix = import source.haskell-nix {};

  pkgs =
    import haskellNix.sources.nixpkgs-2003 haskellNix.nixpkgsArgs;

  hsPkgs = with pkgs.haskell-nix; stackProject {
    src = cleanSourceHaskell {
      src = source.hls-master;
      name = "hls-source";
    };
    cache = null;

    stackYaml = "stack-8.8.3.yaml";
  };
in
  hsPkgs
