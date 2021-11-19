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


