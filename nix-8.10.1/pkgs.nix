{
  extras = hackage:
    {
      packages = {
        "Cabal" = (((hackage.Cabal)."3.2.0.0").revisions).default;
        "cabal-helper" = (((hackage.cabal-helper)."1.1.0.0").revisions).default;
        "clock" = (((hackage.clock)."0.7.2").revisions).default;
        "floskell" = (((hackage.floskell)."0.10.3").revisions).default;
        "ghc-exactprint" = (((hackage.ghc-exactprint)."0.6.3").revisions).default;
        "ghc-lib-parser" = (((hackage.ghc-lib-parser)."8.10.1.20200523").revisions).default;
        "lens" = (((hackage.lens)."4.19.1").revisions).default;
        "monad-dijkstra" = (((hackage.monad-dijkstra)."0.1.1.2").revisions).default;
        "optics-core" = (((hackage.optics-core)."0.3").revisions).default;
        "semigroups" = (((hackage.semigroups)."0.18.5").revisions).default;
        "temporary" = (((hackage.temporary)."1.2.1.1").revisions).default;
        haskell-language-server = ./haskell-language-server.nix;
        ghcide = ./ghcide.nix;
        cabal-plan = ./cabal-plan.nix;
        shake = ./shake.nix;
        };
      compiler.version = "8.10.1";
      compiler.nix-name = "ghc8101";
      };
  resolver = "nightly-2020-05-12";
  modules = [
    ({ lib, ... }:
      {
        packages = {
          "haskell-language-server" = {
            flags = {
              "agpl" = lib.mkOverride 900 false;
              "pedantic" = lib.mkOverride 900 true;
              };
            };
          };
        })
    { packages = {}; }
    ];
  compiler = "ghc-8.10.1";
  }