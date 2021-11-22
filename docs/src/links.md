```@setup links
repositoryroot = pwd() |> dirname |> dirname
```

# Links

In links and image references, URLs and absolute file paths are kept unchanged in the composite file.  So are internal links to other parts of the document (markdown links begining with `#`).  

!!! warning "Warning"

    It's up to you to ensure that internal links are unique within the composite document.  If several different files of your `just-the-docs` site link to `#introduction`, for example, the result in the composite will be syntactically valid CommonMark with unspecified semantics.



## Example of links passed through unchanged

The `test/data/internallink` has a single file with examples of a link and image reference.

```@example links
externallink = joinpath(repositoryroot, "test", "data", "externallink")
srcfile = joinpath(externallink, "f1.md")
read(srcfile) |> String |> print
```

The output from `composite` is unchanged.


```@example links
using UnifyJustTheDocs
composite(externallink) |> String |> print
```

## Relative references


Relative file paths, on the other hand, would be meaningless in the composite file. The `test/data/externallink` directory has two brief files, `f1.md` and `f2.md`; the second includes a link to the first with a relative file link.

```@example links
f2 = joinpath(repositoryroot, "test", "data", "internallink", "f2.md)
read(f2) |> String |> print
```

For *image* links (content bracketed in markdown by `![` and `]`, with image destination in parentheses), relative paths are replaced with absolute paths, since links relative the original source page would be meaningless once the hierarchical page organization of the original web site has been flattened into a single file.

The resulting markdown can be directly used by other markdown-aware applications, such as pandoc to generate PDF or other formatted files.




```@example links
#=
internallink = joinpath(repositoryroot, "test", "data", "internallink")

using UnifyJustTheDocs
markdown = composite(samplesite)
markdown |> String |> print
=#
```