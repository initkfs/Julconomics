#!/usr/bin/env julia
#
# Author: initkfs 2019
#
module ContactsGraphTest

using LightGraphs, GraphPlot
import Cairo, Fontconfig
using Compose

function run()

    contactsData = [
        ("John","Robert"),
        ("William","Thomas"),
        ("Thomas","Robert"),
        ("Robert", "William"),
    ]

    nodesNamesFromTuples::Array{String} = collect(Iterators.flatten(contactsData))
    uniqueNodes::Array{String} = unique(nodesNamesFromTuples);
    sort!(uniqueNodes)

    nodesCount=length(uniqueNodes)
    adjacencyMatrix::Array{Int64,2} = zeros(Int64, nodesCount, nodesCount)
    
    #name=>index, "John"=>1
    nodeIndexCacheMap = Dict(node=>index for (index,node) in enumerate(uniqueNodes))

    for nodeTuple in contactsData

        @assert length(nodeTuple) == 2
        nodeFirst = nodeTuple[1]
        nodeSecond = nodeTuple[2]

        @assert haskey(nodeIndexCacheMap, nodeFirst)
        @assert haskey(nodeIndexCacheMap, nodeSecond)

        firstNodeIndex = nodeIndexCacheMap[nodeFirst]
        secondNodeIndex = nodeIndexCacheMap[nodeSecond]
        
        #set graph edge between nodes
        adjacencyMatrix[[firstNodeIndex],[secondNodeIndex]] = [1]
        #The matrix must be symmetrical!
        adjacencyMatrix[[secondNodeIndex], [firstNodeIndex]] = [1]

    end

    graph = Graph(adjacencyMatrix)
    graphPlot = gplot(graph, nodelabel=uniqueNodes)

    outFile = "$(@__DIR__)/graph.png"
    Compose.draw(PNG(outFile, 16cm, 16cm), graphPlot)
end

@time run()

end

