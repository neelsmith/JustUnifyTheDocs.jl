
# readdir
# walkdir
# basename
# dirname

function readyaml(f)
    lines = readlines(f)
    yaml = []
    index = 2
    l = ""
    while l != "---"
        push!(yaml, l)
        l = lines[index]
        index = index + 1
    end
    yaml
end

function walker(starthere)
    for (root, dirs, files) in walkdir(starthere)
        for dir in dirs
            if occursin("/_", root) || occursin("/.", root)
                # skip
            else
                md = filter(f -> endswith(f, ".md"), files)
                if isempty(md) 
                    # skip
                else
                    fullpaths = map(f -> joinpath(root, dir, f), md)
                    println("Process ", fullpaths)
                end
            end
        end
    end
end