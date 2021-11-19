# API documentation


## All you normally need to create markdown from a Jekyll source directory

```@docs
composite
```

## Page structures

If you want to work with the parsed tree of pages, the main data structure you can use is:

```@docs
JTDPage
```

Functions for creating and working with `JTDPage`s:

```@docs
readpages
rootpages
childpages
```


## Utilities


```@docs
UnifyJustTheDocs.rootpage
UnifyJustTheDocs.stripquotes
UnifyJustTheDocs.tidyvalue
UnifyJustTheDocs.pageparts
UnifyJustTheDocs.adjustpaths
```