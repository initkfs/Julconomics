#!/usr/bin/env julia
#
# Author: initkfs 2019
#
module SimpleFinancialTest

include("$(@__DIR__)/SimpleFinancial.jl")

using .SimpleFinancial
using Test

function main()

    rateResult = SimpleFinancial.fixedProfitabilityRate(big(27.0), big(42.0), big(1.5));
    @test rateResult ≈ 0.37037037

    fixedCompoundInterestResult = SimpleFinancial.fixedCompoundInterest(big(50000.0), big(10.0), big(5.0));
    @test fixedCompoundInterestResult ≈ 80525.5
   
end

@time main()

end