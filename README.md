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

# This derivaiton makes a slides.tar.gz which contains an `index.html`
# and all the relevant styles and JavaScript
nix2slides.mkDerivation {
  name = "My derivation name";

  # Title of the HTML page for the slide deck
  title = "My Slide Deck";

  # See https://revealjs.com/themes/ for valid themes
  theme = "sky";

  # A list of multi-line markdown strings that represent your slides
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
