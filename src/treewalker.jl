
# readdir
# walkdir
# basename
# dirname

function jtdpage(f)
    lines = readlines(f)
    yaml = []
    index = 2
    l = ""
    while l != "---"
        if ! isempty(l)
            push!(yaml, l)
        end
        l = lines[index]
        index = index + 1
    end
    propertydict =  Dict() 
    for conf in yaml
        parts = split(conf, ":")
        propertydict[parts[1]] = join(parts[2:end], ": ")
    end

      parentval = haskey(propertydict, "parent") ? propertydict["parent"] : nothing
    gpval = haskey(propertydict, "grand_parent") ? propertydict["grand_parent"] : nothing
    navorder = haskey(propertydict, "nav_order") ? parse(Int64, propertydict["nav_order"]) : nothing
    md = join(lines[index:end] , "\n\n")
    JTDPage(parentval, gpval, navorder, md)    
end

function readpages(starthere)
    jtdpages = JTDPage[]
    for (root, dir, files) in walkdir(starthere)
        mdfiles = filter(f -> endswith(f, ".md"), files)
        for mdfile in mdfiles
            if occursin("/_", root) || occursin("/.", root)
                # skip
            else
                fullpath = joinpath(root, mdfile)

                @info("--> ", fullpath, isfile(fullpath))
                push!(jtdpages, (jtdpage(fullpath)))
            end
        end
    end
    jtdpages
end
