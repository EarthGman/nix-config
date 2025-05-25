{ pkgs, ... }:
with pkgs.vscode-extensions; [
  # nix
  bbenoist.nix
  jnoortheen.nix-ide
  b4dm4n.vscode-nixpkgs-fmt

  # cpp
  ms-vscode.cpptools
  ms-vscode.cmake-tools

  # python
  # ms-python.vscode-pylance

  # lua
  sumneko.lua

  #rust
  rust-lang.rust-analyzer

  # utilities
  naumovs.color-highlight
  vscode-icons-team.vscode-icons
  tomoki1207.pdf
  ms-vscode-remote.remote-ssh
  nefrob.vscode-just-syntax
]
