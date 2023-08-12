# UnifyJustTheDocs

> Create a single Markdown file from a Jekyll web site built with the `just-the-docs` theme.


## TL;DR

```@setup guide
repositoryroot = pwd() |> dirname |> dirname
```

Use the `composite` function to create a markdown string with the complete content
of the sample Jekyll site in this repository's `test/data/samplesite` directory:

```@example guide
samplesite = joinpath(repositoryroot, "test", "data", "samplesite")

using UnifyJustTheDocs
markdown = composite(samplesite)
typeof(markdown)
```

The first characters look like this:

```@example guide
print(markdown[1:103])
```


## What it does

Patrick Marsceill's [`just-the-docs` Jekyll theme](https://pmarsceill.github.io/just-the-docs/) creates clean, easily navigated web sites with minimal configuration.  Files can be arbitrarily named and kept in directories to any depth of nested subdirectories.  The structure of the web site is determined by a combination of YAML settings organizing pages' navigation order in up to three hierarchical levels.`UnifyJustTheDocs` recursively reads all `.md` files in a file system, and uses `just-the-docs`'s conventions to sequence pages from the files' YAML settings.  The `composite` function (illustrated above) concatenates the markdown content of all the files into a single string which you could then use to do things like typeset a PDF with [pandoc](https://pandoc.org).

## Documentation

This documentation was built using [Documenter.jl](https://github.com/JuliaDocs).

```@example
using Dates # hide
println("Documentation built $(Dates.now()) with Julia $(VERSION) on $(Sys.KERNEL)") # hide
```
