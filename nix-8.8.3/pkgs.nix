{
  extras = hackage:
    {
      packages = {
        "apply-refact" = (((hackage.apply-refact)."0.7.0.0").revisions).default;
        "bytestring-trie" = (((hackage.bytestring-trie)."0.2.5.0").revisions).default;
        "cabal-helper" = (((hackage.cabal-helper)."1.1.0.0").revisions).default;
        "clock" = (((hackage.clock)."0.7.2").revisions).default;
        "constrained-dynamic" = (((hackage.constrained-dynamic)."0.1.0.0").revisions).default;
        "floskell" = (((hackage.floskell)."0.10.3").revisions).default;
        "ghc-check" = (((hackage.ghc-check)."0.3.0.1").revisions).default;
        "ghc-lib-parser" = (((hackage.ghc-lib-parser)."8.10.1.20200523").revisions).default;
        "ghc-lib-parser-ex" = (((hackage.ghc-lib-parser-ex)."8.10.0.4").revisions).default;
        "haskell-lsp" = (((hackage.haskell-lsp)."0.22.0.0").revisions).default;
        "haskell-lsp-types" = (((hackage.haskell-lsp-types)."0.22.0.0").revisions).default;
        "haskell-src-exts" = (((hackage.haskell-src-exts)."1.21.1").revisions).default;
        "hie-bios" = (((hackage.hie-bios)."0.5.0").revisions).default;
        "hlint" = (((hackage.hlint)."2.2.8").revisions).default;
        "hoogle" = (((hackage.hoogle)."5.0.17.11").revisions).default;
        "hsimport" = (((hackage.hsimport)."0.11.0").revisions).default;
        "ilist" = (((hackage.ilist)."0.3.1.0").revisions).default;
        "lsp-test" = (((hackage.lsp-test)."0.10.3.0").revisions).default;
        "monad-dijkstra" = (((hackage.monad-dijkstra)."0.1.1.2").revisions).default;
        "opentelemetry" = (((hackage.opentelemetry)."0.4.0").revisions).default;
        "ormolu" = (((hackage.ormolu)."0.0.5.0").revisions).default;
        "semigroups" = (((hackage.semigroups)."0.18.5").revisions).default;
        "stylish-haskell" = (((hackage.stylish-haskell)."0.11.0.0").revisions).default;
        "temporary" = (((hackage.temporary)."1.2.1.1").revisions).default;
        haskell-language-server = ./haskell-language-server.nix;
        ghcide = ./ghcide.nix;
        shake = ./shake.nix;
        };
      };
  resolver = "lts-15.12";
  modules = [
    ({ lib, ... }:
      {
        packages = {
          "haskell-language-server" = {
            flags = { "pedantic" = lib.mkOverride 900 true; };
            };
          };
        })
    { packages = {}; }
    ];
  }