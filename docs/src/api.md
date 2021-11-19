# API documentation


## All you normally need

The function to create markdown from a Jekyll source directory:

```@docs
composite
```

## Page structures

The main data structure:

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

Internal functions:

```@docs
UnifyJustTheDocs.rootpage
UnifyJustTheDocs.stripquotes
UnifyJustTheDocs.tidyvalue
UnifyJustTheDocs.pageparts
UnifyJustTheDocs.adjustpaths
```