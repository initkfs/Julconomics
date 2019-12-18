#!/usr/bin/env julia
#
# Author: initkfs 2019
#
module ContentMorphologicalGenenatorTest

include("$(@__DIR__)/ContentMorphologicalGenenator.jl")

using .ContentMorphologicalGenenator
using Test, DataFrames, CSVFiles

function main()

    contentInfoDataPath = "$(@__DIR__)/ru"
    @assert isdir(contentInfoDataPath)

    contentFormFile = joinpath(contentInfoDataPath, "ContentForm.txt")
    @assert isfile(contentFormFile)

    contentTypesFile = joinpath(contentInfoDataPath, "ContentTypes.txt")
    @assert isfile(contentTypesFile)

    contentFormTable = DataFrame(Form = readlines(contentFormFile))
    contentTypesTable = DataFrame(Type = readlines(contentTypesFile))
   
    resultTable = ContentMorphologicalGenenator.run(contentFormTable, contentTypesTable)

    @test isa(resultTable, DataFrames.AbstractDataFrame)
    
    outFile = "$(@__DIR__)/out.txt"
    open(outFile, "w") do io
        DataFrames.show(io, resultTable)
    end
end

@time main()

end