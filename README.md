# JustUnifyTheDocs.jl

Read markdown source for a jekyll web site using the "just-the-docs" theme, and create a single source file suitable for generating a PDF with pandoc.

The module determines the sequence of files by looking at these properties in the YAML headings for the ["just-the-docs" theme](https://pmarsceill.github.io/just-the-docs/):

- `parent`
- `grand_parent`
- `nav_order`


## Briefest possible summary

Add the package:

```
pkg> add https://github.com/neelsmith/JustUnifyTheDocs.jl
```


Build a composite markdown file with all content from your web site:

```julia
using JustUnifyTheDocs
markdown = composite(DIRECTORY_ROOT)
```