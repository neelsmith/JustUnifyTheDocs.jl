# JustUnifyTheDocs.jl

Read markdown source for a jekyll web site using the "just-the-docs" theme, and create a single source file suitable for generating a PDF with pandoc.

The module determines the sequence of files by looking at these properties in the YAML headings for the ["just-the-docs" theme](https://pmarsceill.github.io/just-the-docs/):

- `parent`
- `grand_parent`
- `nav_order`