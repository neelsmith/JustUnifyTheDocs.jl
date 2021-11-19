
"""Split markdown file into YAML header and markdown body.
Returns a tuple of 2 strings.  If there is no YAML header, 
the first string will be empty.

$(SIGNATURES)
"""
function pageparts(f)
    lines = readlines(f)
    yaml = []
    markdown = []
    index = 1
    inheader = false
   
    for l in lines
        if inheader
            if l == "---"
                inheader = false
            else
                push!(yaml, l)  
            end

        else
            if l == "---"
                inheader = true
            else
                push!(markdown, l)  
            end
        end
    end
    (join(yaml, "\n"), join(markdown, "\n"))
end

"""Create a `JTDPage` from a markdown file including YAML header for use with the `just-the-docs` jekyll theme.

$(SIGNATURES)

`f` should be the explicit full page (Julia `realpath()`) to a markdown file.
"""
function jtdpage(f)
    (yaml, rawmd) = pageparts(f)
    propertydict = YAML.load(yaml)
    title = haskey(propertydict, "title") ? propertydict["title"] : "Untitled page"
    parentval = haskey(propertydict, "parent") ? propertydict["parent"] : nothing
    gpval = haskey(propertydict, "grand_parent") ? propertydict["grand_parent"] : nothing
    navorder = haskey(propertydict, "nav_order") ? propertydict["nav_order"] : 0
    md = adjustpaths(rawmd, dirname(f))
    JTDPage(title, parentval, gpval, navorder, md)    
end

"""Remove any leading and trailing quotation marks.

$(SIGNATURES)
"""
function stripquotes(s)
    subbed = s
    for rs in [
       r"^\"" => "",
       r"\"$" => ""
        ]
        subbed = replace(subbed,rs)
    end
    subbed
end

"""Tidy up strings from YAML settings by stripping
leading/trailing whitespace, and removing any outer quotes.

$(SIGNATURES)
"""
function tidyvalue(propvalue)
    strip(propvalue) |> stripquotes
end

"""Recursively read directories of markdown files
into a list of `JTDPage`s.

$(SIGNATURES)
"""
function readpages(starthere)
    srcpath = realpath(starthere)
    @info("Reading markdown source files from ", srcpath)
    
    jtdpages = JTDPage[]
    for (root, dir, files) in walkdir(srcpath)
        mdfiles = filter(f -> endswith(f, ".md"), files)
        for mdfile in mdfiles
            if occursin("/_", root) || occursin("/.", root)
                # skip
            else
                fullpath = joinpath(root, mdfile)
                push!(jtdpages, (jtdpage(fullpath)))
            end
        end
    end
    @info("Pages read: ", length(jtdpages))
    jtdpages
end


