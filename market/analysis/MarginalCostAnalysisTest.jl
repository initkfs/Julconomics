#!/usr/bin/env julia
# Author: initkfs 2020
#
module MarginalCostAnalysisTest

using ForwardDiff
using Test

function run()

# y = production costs
# x = production volume
# 50x - 0.05x^3 = production function
#
# average production costs?
# marginal production costs?
# where volume of production = 10

x = 10
y(x) = 50x - 0.05(x^3)

derivativeOfVolume::AbstractFloat = ForwardDiff.derivative(y, x)
averageCosts::AbstractFloat = y(x) / x

println("""
Average production costs per unit: $averageCosts
Increase production volume per unit will cost: $derivativeOfVolume
""")

@test derivativeOfVolume == 35
@test averageCosts == 45

end

@time run()

end
