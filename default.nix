{pkgs ? import <nixpkgs> {}}: let
  nix2html = import (fetchTarball {
    url = "https://github.com/davidnuon/nix2html/archive/refs/tags/0.0.3.tar.gz";
  }) {};
  revealJS = fetchTarball {
    url = "https://github.com/hakimel/reveal.js/archive/refs/tags/4.6.0.tar.gz";
  };
  components = import ./components {inherit nix2html;};
in rec {
  slidesHTML = title: theme: content: nix2html.render (components.slides title theme content);

  mkDerivation = {
    name ? "nix2slides",
    theme ? "sky",
    title ? "nix2slides",
    content ? [
      ''
        # Hello, nix2slides
      ''
    ],
  }:
    pkgs.stdenv.mkDerivation rec {
      inherit revealJS name;
      unpackPhase = "true";

      buildPhase = '''';

      fileContents = with nix2html; (slidesHTML title theme content);

      outputFile = pkgs.writeText "index.html" fileContents;

      installPhase = ''
        mkdir $out
        cp -r $revealJS/plugin $out
        cp $revealJS/dist/reveal.css $out
        cp $revealJS/dist/reveal.js $out
        cp -R $revealJS/dist/theme $out/theme
        cp $outputFile $out/index.html
      '';
    };
}
