# JustUnifyTheDocs.jl

> Assemble markdown source for a jekyll web site using JustTheDocs theme into source for generating a PDF with pandoc.

Requirements:

- walk file tree of source directory and read all YAML headers
- record the following properties:
    - `nav_order`
    - `parent`
    - `grand_parent`
- build a DAG of the files
