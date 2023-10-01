{nix2html}: let
in
  with nix2html; rec {
    slidesContainer = slides:
      div {
        attributes = {
          style = "font-size:40px;";
          class = "reveal";
        };

        children = [
          (div
            {
              attributes = {
                class = "slides";
              };

              children = slides;
            })
        ];
      };

    slide = children:
      section {
        inherit children;
      };

    mdSlide = markdown:
      section {
        attributes = {
          "data-markdown" = "";
        };
        children = [
          (textarea
            {
              attributes = {
                "data-template" = "";
              };
              children = [
                markdown
              ];
            })
        ];
      };

    document = {
      pageTitle ? "nix2slides",
      children ? [],
      scripts ? [],
      stylesheets ? [],
      footer ? [],
    }: let
      scriptTags = map (src:
        script {
          attributes = {inherit src;};
        })
      scripts;

      styleTags = map (href:
        link {
          attributes = {
            rel = "stylesheet";
            inherit href;
          };
        })
      stylesheets;
    in
      html {
        children = [
          (head {
            children =
              [
                (title {
                  children = [
                    pageTitle
                  ];
                })
              ]
              ++ styleTags;
          })
          (body {
            children = children ++ scriptTags ++ footer;
          })
        ];
      };

    slides = title: theme: mdContent:
      document {
        pageTitle = title;
        children = [
          (
            slidesContainer (map mdSlide mdContent)
          )
        ];
        scripts = [
          "./reveal.js"
          "./plugin/markdown/markdown.js"
        ];
        stylesheets = [
          "./reveal.css"
          "./theme/${theme}.css"
        ];

        footer = [
          (nix2html.script
            {
              children = [
                ''Reveal.initialize({ plugins: [ RevealMarkdown ]});''
              ];
            })
        ];
      };
  }
