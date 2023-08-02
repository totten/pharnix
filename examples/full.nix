{ pkgs ? import <nixpkgs> {} }:

let

/*
  pharnix = pkgs.callPackage (pkgs.fetchFromGitHub {
    owner = "totten";
    repo = "pharnix";
    rev = "v0.2.0";
    sha256 = "fixme"; 
  }) {};
*/

  pharnix = pkgs.callPackage (import ../default.nix) {};

in

  pkgs.mkShell {
    nativeBuildInputs = pharnix.profiles.full ++ [
      pkgs.bash-completion
    ];
    shellHook = ''
      source ${pkgs.bash-completion}/etc/profile.d/bash_completion.sh
    '';
  }
