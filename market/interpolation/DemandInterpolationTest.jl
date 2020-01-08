#!/usr/bin/env julia
#
# Author: initkfs 2020
#
module DemandInterpolationTest

using Interpolations
using Plots

function main()

    xPriceValues = 1:20
    #Replace the linear function 'a + b * price' for convenient plotting
    sumAllDemandFactors = 20.5
    demandFromPrice(xPrice) = sumAllDemandFactors / xPrice
    #vectorized version of demand function with dot operator "."
    yDemandValues::Array{Float64, 1} = demandFromPrice.(xPriceValues)

    demandFromPricePlot = Plots.plot(xPriceValues, yDemandValues, seriestype=:scatter, label = "Demand function", xlabel="Price", ylabel="Demand", fmt = :png)
    
    linearInterpolation = Interpolations.LinearInterpolation(xPriceValues, yDemandValues)
    splineInterpolation = Interpolations.CubicSplineInterpolation(xPriceValues, yDemandValues)

    interpolationsRange = 1.5:19.5

    #Simple helper function for plotting
    plotInterpolation!(interpolator::Interpolations.Extrapolation, labelText::String) = plot!(interpolationsRange, interpolator.(interpolationsRange), label = labelText)

    plotInterpolation!(linearInterpolation, "linear interpolation")
    plotInterpolation!(splineInterpolation, "spline interpolation")

    outFile = "$(@__DIR__)/demand.png"
    Plots.savefig(demandFromPricePlot, outFile)
end

@time main()

end