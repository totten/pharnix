{}:

rec {

  pkgSrc = fetchTarball {
    url = "https://github.com/nixos/nixpkgs/archive/ce6aa13369b667ac2542593170993504932eb836.tar.gz";
    sha256 = "0d643wp3l77hv2pmg2fi7vyxn4rwy0iyr8djcw1h5x72315ck9ik";
  };

  pkgs = import pkgSrc {};

  fetchPhar = pkgs.callPackage (import ./fetchPhar.nix) {};

  php = pkgs.php81.buildEnv {
    extraConfig = ''
      memory_limit=-1
      phar.readonly=0
    '';
  };

  ## "lib" is a collection of random PHARs that are useful in building
  lib = rec {
    composer = pkgs.php81Packages.composer;

    box = fetchPhar {
      name = "box";
      url = https://github.com/box-project/box/releases/download/4.3.7/box.phar;
      sha256 = "sCNa7zeyWO9yluzRETsbkFXBaWLnm01xCVDW6kP8KUw=";
    };

    pogo = fetchPhar {
      name = "pogo";
      url = https://github.com/totten/pogo/releases/download/v0.5.0/pogo-0.5.0.phar;
      sha256 = "heH1JFa3EGz069C+7a4YKtLEDYXShTAg0eIjx2jgASk=";
    };

    phive = fetchPhar {
      name = "phive";
      url = "https://github.com/phar-io/phive/releases/download/0.15.2/phive-0.15.2.phar";
      sha256 = "sha256-3uXSkAFl+EHt3Dr2X61Mg+JxUyqXfmXeewLRXsg3dck=";
    };

    phpunit8 = fetchPhar {
      name = "phpunit8";
      url = "https://phar.phpunit.de/phpunit-8.5.27.phar";
      sha256 = "sha256-LmJP8mj77jrNOEm9XI/6ktI0FngQsmLBS1qy7C8wNUo=";
    };

    phpunit9 = fetchPhar {
      name = "phpunit9";
      url = "https://phar.phpunit.de/phpunit-9.6.5.phar";
      sha256 = "sha256-+sFZ5FIVdhZ+/84/mGaVvyQHyDuile35r2FRSGpVHx8=";
    };

  };

  ## "profiles" is a list of suggested packages for making a shell environment
  profiles = rec {

    base = [
      php
      pkgs.bzip2
      pkgs.coreutils
      pkgs.curl
      pkgs.gettext
      pkgs.gh
      pkgs.git
      pkgs.gnugrep
      pkgs.gnused
      pkgs.gnutar
      pkgs.hostname
      pkgs.moreutils
      pkgs.ncurses
      pkgs.patch
      pkgs.rsync
      pkgs.subversion
      pkgs.unzip
      pkgs.which
      pkgs.zip
    ];

    full = base ++ [
      lib.box
      lib.composer
      lib.phive
      lib.pogo
      lib.phpunit8
      lib.phpunit9
    ];

  };

}
