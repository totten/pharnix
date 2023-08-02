/**
 * mkPhar - A very small function download a PHAR executable and
 * register in the `bin/` folder.
 *
 * These PHARs are *not* statically linked to PHP. You will have to
 * mix-in your own PHP-CLI.
 *
 * Usage:
 *   let
 *     mkPhar = pkgs.callPackage (pkgs.fetchFromGitHub {owner="totten"; repo="phar-nix"; rev="0.1.0";}) {};
 *     box = mkPhar {
 *       name = "box";
 *       url = "https://github.com/box-project/box/releases/download/4.3.7/box.phar";
 *       sha256 = "...";
 *     }
 *   in ...
 */

{ stdenv, fetchurl }: phar:

stdenv.mkDerivation rec {
  name = phar.name;
  src = fetchurl {
    url = phar.url;
    sha256 = phar.sha256;
    executable = true;
  };
  buildInputs = [ ];
  buildCommand = ''
    mkdir $out $out/bin
    pushd $out/bin
      ln -s ${src} $out/bin/${name}
    popd
  '';
}
