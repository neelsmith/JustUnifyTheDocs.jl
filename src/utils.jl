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