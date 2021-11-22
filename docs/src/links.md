

# Links

```@setup links
src = joinpath(dirname(pwd()), "src")
cp(joinpath(src, "assets","internallink"), joinpath(pwd(), "assets","internallink"), force=true)
cp(joinpath(src, "assets","externallink"), joinpath(pwd(), "assets","externallink"), force=true)
```

In links and image references, URLs and absolute file paths are kept unchanged in the composite file.  So are internal links to other parts of the document (markdown links begining with `#`).  

!!! warning "Warning"

    It's up to you to ensure that internal links are unique within the composite document.  If several different files of your `just-the-docs` site link to `#introduction`, for example, the result in the composite will be syntactically valid CommonMark with unspecified semantics.



## Example of links passed through unchanged

The `assets/internallink` directory has a single file with examples of a link and image reference.

```@example links
externallink = joinpath("assets", "externallink")
srcfile = joinpath(externallink, "f1.md")
read(srcfile) |> String |> print
```

The output from `composite` is unchanged.


```@example links
using UnifyJustTheDocs
composite(externallink) |> String |> print
```

## Relative references: images

For *image* links, relative paths are replaced with absolute paths, since links relative the original source page would be meaningless once the hierarchical page organization of the original web site has been flattened into a single file.

The resulting markdown can be directly used by other markdown-aware applications, such as pandoc to generate PDF or other formatted files.

!!! warning "Warning"

    The absolute paths will only be valid on the system where the composite was built so the resulting composite is *not* portable to other systems.


## Relative references: local files

Relative file paths are also meaningless in the composite file.  The `composite` functions accepts an optional `pandoc_anchors` parameter you can use to insert a pandoc-style named anchor in the composite at the point where each file begins, and convert
relative file links to correspnoding internal references.


This is most easily seen with an example.  The `assets/externallink` directory has two short files, `f1.md` and `f2.md`; the second includes a link to the first with a relative file link.

```@example links
f2 = joinpath("assets", "internallink", "f2.md")
read(f2) |> String |> print
```


Notice that when we set the `pandoc_anchors` parameter to true, the composite now includes an empty header `#` with a pandoc named anchor at the points where content from `f1` and `f2` begin.  The name for the anchor point is derived from the path to the file; the relative references to `f1` in `f2` is converted to the internal reference marking the beginning of `f1`.


```@example links
internallink = joinpath("assets", "internallink")
composite(internallink, pandoc_anchors = true) |> String |> print
```

Using `pandoc_anchors`, you can use portable relative references in your markdown source files, and produce a composite with portable internal references that can be processed by pandoc on any system.
