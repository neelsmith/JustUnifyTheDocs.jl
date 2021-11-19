

# How it works

The `readpages` functions recursively looks at content of a given directory and creates a Vector of `JTDPage`s.  The current version of `UnifyJustTheDocs` makes the following assumptions:

- invisible directories (names starting with `.`) are skipped
- directories reserved for Jekyll's use (names starting with `_`) are skipped
- markdown files with content for the site are assumed to have names ending in `.md` 

Each `JTDPage` records any YAML settings for `parent`, `grand_parent` and `nav_order` as well as the title and markdown content.  If the file has no setting for `parent`, `grand_parent`, their value is `nothing`; if the file has no `nav_order` settings, its value is `0`.

To assemble the markdown pages in the proper order, the `composite` function first groups them in `just-the-docs`' three hierarchical tiers.  Within each tier, pages are sorted by the `nav_order` value.


## A note on links

For *image* links (content bracketed in markdown by `![` and `]`, with image destination in parentheses), relative paths are replaced with absolute paths, since links relative the original source page would be meaningless once the hierarchical page organization of the original web site has been flattened into a single file.

The resulting markdown can be directly used by other markdown-aware applications, such as pandoc to generate PDF or other formatted files.

As of version `0.2.x`, other kinds of links are left unaltered.

