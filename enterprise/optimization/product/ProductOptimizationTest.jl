#!/usr/bin/env julia
#
# Author: initkfs 2019
#
module ProductOptimizationTest

include("$(@__DIR__)/ProductOptimization.jl")

import .ProductOptimization
import CSV, MathOptInterface
using Test, Logging

function main()
    productsDataPath = "$(@__DIR__)/products.csv"
    @assert isfile(productsDataPath)

    productTable = CSV.read(productsDataPath)

    optimizationResult = ProductOptimization.run(productTable)

    @test !isnothing(optimizationResult)
    @test isa(optimizationResult,  ProductOptimization.OptimizationResult)

    status = optimizationResult.status
    @test isequal(MathOptInterface.OPTIMAL, status)

    resultArray = optimizationResult.optimizedValuesArray
    @test [1.0, 5.0, 6.0, 0.0] ≈ resultArray
end

@time main()

end