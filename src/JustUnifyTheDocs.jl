module JustUnifyTheDocs


using Documenter, DocStringExtensions

include("treewalker.jl")
include("jtdpage.jl")

export JTDPage
export jtdpage
export readpages, rootpages, childpages #, grandchildpages
export composite

end # module
