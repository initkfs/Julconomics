#!/usr/bin/env julia
# Author: initkfs 2019
#
module TextReportGeneratorTest

using ExcelReaders, DataFrames, UnicodePlots

function run()

    #WARNING!
    #The data file is not included in the repository for licensing reasons.
    #see https://data.gov.ru/opendata/7708523530-grainexport
    dataFile = "$(@__DIR__)/data.xlsx"
    @assert isfile(dataFile)

    excelData = readxlsheet(dataFile, "Лист1", skipstartrows=1, nrows=20)
    @assert length(excelData) > 0

    dataTable = Base.convert(DataFrame, excelData)

    chartX = String[]
    chartY = Float64[]
    for row in DataFrames.eachrow(dataTable)
        push!(chartX, string(row.x1))
        push!(chartY, float(row.x2))
    end

    @assert length(chartX) == length(chartY)
    
    plotResult = UnicodePlots.barplot(chartX, chartY)
    
    outFile = "$(@__DIR__)/out.txt"
    stringResult = string(plotResult)
    open(outFile, "w") do io
        write(io, stringResult)
    end
end

@time run()

end