module UnifyJustTheDocs


using Documenter, DocStringExtensions
using YAML
using CommonMark

include("treewalker.jl")
include("jtdpage.jl")
include("links.jl")


export JTDPage
export jtdpage
export readpages, rootpages, childpages
export composite

end # module
