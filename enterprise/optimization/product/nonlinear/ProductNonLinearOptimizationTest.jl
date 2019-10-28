#!/usr/bin/env julia
#
# Author: initkfs 2019
#
module ProductNonLinearOptimizationTest

using Test, JuMP, Ipopt
#
# First quantity of product: x1
# Second quantity of product: x2
# Total amount: 200
#
# Criterion: Cost of product sales, minimization
# First way to sell, cost: 4x1 + x1^2
# Second way to sell, cost: x2^2
#
function main()

    #4x1 + x1^2 + x2^2 -> min
    #x1 + x2 = 200
    #x1 >= 0
    #x2 >= 0

    totalAmount = 200

    model = Model(with_optimizer(Ipopt.Optimizer, print_level=0))

    @variable(model, x1, start = 0.0)
    @variable(model, x2, start = 0.0)
 
    @NLobjective(model, Min, 4x1 + x1^2 + x2^2)

    @constraint(model, x1 + x2 == totalAmount)
    @constraint(model, x1 >= 0)
    @constraint(model, x2 >=0)

    optimize!(model)

    x1Result = round(value(x1))
    x2Result = round(value(x2))

    @test x1Result == 99
    @test x2Result == 101
    @test x1Result + x2Result == totalAmount
end

@time main()

end