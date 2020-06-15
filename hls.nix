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
    cache = [
      {
        name = "shake";
        url = "https://github.com/wz1000/shake";
        rev = "fb3859dca2e54d1bbb2c873e68ed225fa179fbef";
        sha256 = "0sa0jiwgyvjsmjwpfcpvzg2p7277aa0dgra1mm6afh2rfnjphz8z";
      }
    ];

    stackYaml = "stack-8.8.3.yaml";
  };
in
  hsPkgs
