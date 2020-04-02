#!/usr/bin/env julia
# Author: initkfs 2020
#
module СalculationAccuracyTest

#FIXME julia 1.3.1, Pkg doesn't work. 
#TODO using StatsBase
using Statistics

function run()

    #Distribution - Normal, p = 0.95
    confidenceProbability = 0.95
    measurementLimit = 200

    actualValue = 50
    measuredValues = skipmissing([50.12, 50.15, 50.16, 50.18, 50.20, 50.23, 50.25, 50.27, 50.28, 50.31])

    #iqr(measuredValues);

    maxValue=maximum(measuredValues)
    meanValue = Statistics.mean(measuredValues)
    standardDeviation = Statistics.stdm(measuredValues, meanValue)

    threeSigmaCheck = (maxValue - meanValue) < 3 * standardDeviation

    absoluteSystematicError = meanValue - actualValue

    probabilityСoefficient = 1.96
    absoluteRandomError = probabilityСoefficient * standardDeviation
    
    absoluteTotalError = absoluteSystematicError + absoluteRandomError 
    relativeTotalError = (absoluteTotalError / actualValue) * 100
    reducedMeasurementTotalError = (absoluteTotalError / measurementLimit) * 100

    roundTo1(x) = round(x, digits=1) 
    
    println("""
Report for measurements:
Mean: $(round(meanValue, digits=4))
Standard deviation: $(round(standardDeviation, digits=4))
$(threeSigmaCheck ? "$maxValue is not miss" : "$maxValue is miss")
Absolute total error: ±$(roundTo1(absoluteTotalError))
Absolute relative error: ±$(roundTo1(relativeTotalError))%
Reduced error: ±$(round(reducedMeasurementTotalError, digits=2))%

Result: $(roundTo1(meanValue))±$(roundTo1(absoluteTotalError)), p=$confidenceProbability
""")

#Report for measurements:
#Mean: 50.215
#Standard deviation: 0.0628
#50.31 is not miss
#Absolute total error: ±0.3
#Absolute relative error: ±0.7%
#Reduced error: ±0.17%
#
#Result: 50.2±0.3, p=0.95
    
end

@time run()

end