# nix2slides

## Make a slidedeck

1. Make a default.nix with the following

```nix
{
  nix2slides ?
    import (fetchTarball {
      url = "https://github.com/davidnuon/nix2slides/archive/refs/heads/main.tar.gz";
    }) {},
}:
nix2slides.mkDerivation {;
  title = "My Slide Deck";
  name = "My derivation name";
  theme = "sky";
  content = [
    ''
      # Hello
    ''

    '' 
      # Slides 2
    ''
  ];
}
```

2. Run `nix-build`
3. Collect `slides.tar.gz`
