{ mobile-nixos
, fetchFromGitLab
, fetchFromGitHub
, fetchpatch
, python3
, ncurses
, ...
}:

mobile-nixos.kernel-builder {
  version = "6.16.9";
  configfile = ./config.aarch64;

  src = fetchFromGitHub {
    owner = "qaz6750";
    repo = "linux-downstream";
    rev = "1c2fe67fb1618b04732a1811c7a21d8ad3fabd31";
    hash = "sha256-qeoL9WfMQjngXZGlqbm8tsjJiUICQ0CSAX36tGkGYNM=";
  };

  patches = [ ];

  nativeBuildInputs = [
    python3
    ncurses.dev
  ];

  isModular = true;
  isCompressed = "gz";
}
