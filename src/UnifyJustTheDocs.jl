module UnifyJustTheDocs


using Documenter, DocStringExtensions

include("treewalker.jl")
include("jtdpage.jl")

export JTDPage
export jtdpage
export readpages, rootpages, childpages
export composite

end # module
