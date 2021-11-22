

# How it works

## `just-the-doc`'s YAML settings

`just-the-doc` identifies pages by a `title` property. Hierarchical relations of pages are identified with `parent` and `grand_parent` properties.  Pages with no `parent` setting default to the root level of the site's page hierarchy.

At each hierarchical level, pages are ordered first according to the `nav_order` YAML setting.  If no `nav_order` property is defined or if two pages have the same value for `nav_order`, they sort alphabetically by the `title` property.

## Ordering pages in a `just-the-doc` site

The `readpages` functions recursively looks at content of a given directory and creates a Vector of `JTDPage`s.  The current version of `UnifyJustTheDocs` makes the following assumptions:

- invisible directories (names starting with `.`) are skipped
- directories reserved for Jekyll's use (names starting with `_`) are skipped
- markdown files with content for the site are assumed to have names ending in `.md` 

Each `JTDPage` records any YAML settings for `parent`, `grand_parent` and `nav_order` as well as the title and markdown content.  If the file has no setting for `parent`, `grand_parent`, their value is `nothing`; if the file has no `nav_order` settings, its value is `0`.

To assemble the markdown pages in the proper order, the `composite` function first groups them in `just-the-docs`' three hierarchical tiers.  Within each tier, pages are sorted by the `nav_order` value.
