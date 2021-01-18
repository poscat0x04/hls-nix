# hls-nix

Nix derivations for [haskell-language-server](https://github.com/haskell/haskell-language-server)

## Introduction

The whole nix expression is stored in one single file `hls.nix`, it is a parameterized function that takes 3 parameters: `source`, `version`, and `tag`.

| param   | default value                 | description                       |
|---------|-------------------------------|-----------------------------------|
| source  | defined in source/default.nix | sources                           |
| version | "8.8.3"                       | compiler version to build against |
| tag     | "master"                      | git tag                           |

the expression then returns a [haskell.nix component](https://input-output-hk.github.io/haskell.nix/reference/library/#component).

To build the actual executable, run `nix build exes.haskell-language-server`.
