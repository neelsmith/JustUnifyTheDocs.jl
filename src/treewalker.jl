"""Read YAML settings into a Dict.

$(SIGNATURES)
"""
function propertydict(f)
    @info("Create page from ", f)
    lines = readlines(f)
    yaml = []
    index = 2
    l = ""
    while l != "---" && index < length(lines)
        push!(yaml, l)
        l = lines[index]
        index = index + 1
    end
    dict =  Dict() 
    for conf in yaml
        parts = split(conf, ":")
        dict[parts[1]] = tidyvalue(join(parts[2:end], ": "))
    end
    dict
end

"""Split markdown file into YAML header and markdown body.

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
    #=
    dict =  Dict() 
    for conf in yaml
        parts = split(conf, ":")
        dict[parts[1]] = tidyvalue(join(parts[2:end], ": "))
    end
    dict
    =#
end

"""Create a `JTDPage` from a markdown file including YAML header for use with the `just-the-docs` jekyll theme.

$(SIGNATURES)

`f` should be the explicit full page (Julia `realpath()`) to a markdown file.
"""
function jtdpage(f)
    #=
    @info("Create page from ", f)
    lines = readlines(f)
    yaml = []
    index = 2
    l = ""
    while l != "---" && index < length(lines)
        push!(yaml, l)
        l = lines[index]
        index = index + 1
    end
    propertydict =  Dict() 
    for conf in yaml
        parts = split(conf, ":")
        propertydict[parts[1]] = tidyvalue(join(parts[2:end], ": "))
    end
    =#
    title = haskey(propertydict, "title") ? propertydict["title"] : "Untitled page"
    parentval = haskey(propertydict, "parent") ? propertydict["parent"] : nothing
    gpval = haskey(propertydict, "grand_parent") ? propertydict["grand_parent"] : nothing
    navorder = haskey(propertydict, "nav_order") ? parse(Int64, propertydict["nav_order"]) : 0
    rawmd = join(lines[index:end], "\n") 

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


"""Rewrite markdown source in `mdsrc` by converting relative paths to full paths.

$(SIGNATURES)
"""
function adjustpaths(mdsrc, dirname)
    #TBA
    mdsrc
end