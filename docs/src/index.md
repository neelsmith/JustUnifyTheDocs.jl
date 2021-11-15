# JustUnifyTheDocs

> Create a single Markdown file from a Jekyll web site using the `just-the-docs` theme.


## TL;DR

```@setup guide
repositoryroot = pwd() |> dirname |> dirname
```

Create a markdown string for the complete content
of the sample Jekyll site in this repository's `test/data/samplesite` directory:

```@example guide
samplesite = joinpath(repositoryroot, "test", "data", "samplesite")
using JustUnifyTheDocs
markdown = composite(samplesite)
typeof(markdown)
```

The first 100 characters look like this:

```@example guide
print(markdown[1:100])
```


## What it does

Patrick Marsceill's [`just-the-docs` Jekyll theme](https://pmarsceill.github.io/just-the-docs/) creates clean, easily navigated web sites with minimal configuration.  Files can be arbitrarily named and kept in directories to any depth of nested subdirectories.  The structure of the web site is determined by a combination of YAML settings organizing pages' navigation order in up to three hierarchical levels.`JustUnifyTheDocs` recursively reads all `.md` files in a file system, and uses `just-the-docs`'s conventions to sequence pages from the files' YAML settings.  The `composite` function (illustrated above) concatenates the markdown content of all the files into a single string which you could then use to do things like typeset a PDF with [pandoc](https://pandoc.org).

### `just-the-doc`'s YAML settings

Pages are identified by a `title` property. Hierarchical relations of pages are identified with `parent` and `grand_parent` properties.  Pages with no `parent` setting default to the root level of the site's page hierarchy.

At each hierarchical level, pages are ordered first according to the `nav_order` YAML setting.  If no `nav_order` property is defined or if two pages have the same value for `nav_order`, they sort alphabetically by the `title` property.


## How it works

The `readpages` functions recursively looks at content of a given directory and creates a Vector of `JTDPage`s.  The current version of `JustUnifyTheDocs` makes the following assumptions:

- invisible directories (names starting with `.`) are skipped
- directories reserved for Jekyll's use (names starting with `_`) are skipped
- markdown files with content for the site are assumed to have names ending in `.md` 

Each `JTDPage` records any YAML settings for `parent`, `grand_parent` and `nav_order` as well as the title and markdown content.  If the file has no setting for `parent`, `grand_parent`, their value is `nothing`; if the file has no `nav_order` settings, its value is `0`.


To assemble the markdown pages in the proper order, the `composite` function first groups them in `just-the-docs`' three hierarchical tiers.  Within each tier, pages are sorted by the `nav_order` value.




