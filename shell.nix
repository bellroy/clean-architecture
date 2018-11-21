{ pkgs ? import <nixpkgs> {} }:

with pkgs;

let
  ruby = pkgs.ruby_2_4;
  bundler = pkgs.bundler.override { inherit ruby; };

in pkgs.stdenv.mkDerivation {
  name = "cleanArchitectureEnv";
  buildInputs = [
    readline
    ruby.devEnv
  ];
}
