<h1 align="center"> Personal neovim configuration </h1>

### Introduction
Neovim configuration for personal use.

### Instalation
TODO

### Features:
- language server configuration for python, yaml, json, lua and vimscript,
- fuzzy finder with telescope
- markdown tools
- snippets
- buffer management
- directory navigation
- UI goodies
- ...

### Development
Requirements:
- luarocks
- pre-commit

```
luarocks install --local --server=https://luarocks.org/dev luaformatter
luarocks install --local luacheck
pre-commit install --hook-type pre-commit
```
