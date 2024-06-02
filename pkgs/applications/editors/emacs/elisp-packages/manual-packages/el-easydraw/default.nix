{ lib
, melpaBuild
, fetchFromGitHub
, writeText
, unstableGitUpdater
, gzip
}:

let
  rev = "13c9fa22155066acfb5a2e444fe76245738e7fb7";
in
melpaBuild {
  pname = "edraw";
  version = "1.2.0-unstable-2024-05-29";

  src = fetchFromGitHub {
    owner = "misohena";
    repo = "el-easydraw";
    inherit rev;
    hash = "sha256-h2auwVIWjrOBPHPCuLdJv5y3FpoV4V+MEOPf4xprfYg=";
  };

  commit = rev;

  packageRequires = [ gzip ];

  recipe = writeText "recipe" ''
    (edraw
      :repo "misohena/el-easydraw"
      :fetcher github
      :files
      ("*.el"
       "msg"))
  '';

  passthru.updateScript = unstableGitUpdater {tagPrefix = "v";};

  meta = {
    homepage = "https://github.com/misohena/el-easydraw";
    description = "Embedded drawing tool for Emacs";
    license = lib.licenses.gpl3;
    maintainers = with lib.maintainers; [ brahyerr ];
    platforms = lib.platforms.all;
  };
}
