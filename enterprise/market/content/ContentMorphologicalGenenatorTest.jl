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

    contentTargetFile = joinpath(contentInfoDataPath, "ContentTarget.txt")
    @assert isfile(contentTargetFile)

    contentTonalityFile = joinpath(contentInfoDataPath, "ContentTonality.txt")
    @assert isfile(contentTonalityFile)

    contentFormTable = DataFrame(Form = readlines(contentFormFile))
    contentTypesTable = DataFrame(Type = readlines(contentTypesFile))
    contentTargetTable = DataFrame(Target = readlines(contentTargetFile))
    contentTonalityTable = DataFrame(Tonality = readlines(contentTonalityFile))
   
    resultTable = ContentMorphologicalGenenator.run(contentFormTable, contentTypesTable, contentTargetTable, contentTonalityTable)

    @test isa(resultTable, DataFrames.AbstractDataFrame)
    
    out = "$(@__DIR__)/out.txt"
    outFileIO = open(out, "w");
    try
        DataFrames.show(outFileIO, resultTable)
    finally
        close(outFileIO)
    end
end

@time main()

end