#
# Author: initkfs 2019
# Testing a simple solution to the problem of optimizing the factory production of enterprise products based on tabular data
# TODO https://discourse.julialang.org/t/how-to-define-a-constraint-from-a-string/12157

module ProductOptimization

export run, OptimizationResult

import DataFrames,
       GLPK,
       MathOptInterface
using JuMP, Printf, Logging

struct OptimizationResult
    status::MathOptInterface.TerminationStatusCode
    optimizedValuesArray::Array{Float64,1}
end

function run(productTable::DataFrames.AbstractDataFrame)::OptimizationResult

    rowsCount = DataFrames.nrow(productTable)
    @assert rowsCount > 0
    columnsCount = DataFrames.ncol(productTable)
    @assert columnsCount > 3

    resourcesTable = productTable[1:(rowsCount - 1), :]
    @assert isa(resourcesTable,  DataFrames.AbstractDataFrame)
    @debug "Received resources data: $resourcesTable"

    productHeaderColumns = map(DataFrames.names(productTable)) do columnNameSymbol
        string(columnNameSymbol)
    end
    @assert !isempty(productHeaderColumns)

    productColumns = ["Product1", "Product2", "Product3", "Product4"]
    for productColumnName in productColumns
        if !(productColumnName in productHeaderColumns)
            throw(ArgumentError(@sprintf "Invalid product table recieved. Not found product column '%s' in product table header %s" productColumnName  productHeaderColumns))
        end
    end

    profitRow = productTable[rowsCount, :]
    @assert isa(profitRow, DataFrames.DataFrameRow)
    @debug "Received profit row: $profitRow"

    productOptimizationModel = JuMP.Model(with_optimizer(GLPK.Optimizer)) 

    @variable(productOptimizationModel, Product1 >= 1)
    @variable(productOptimizationModel, Product2 >= 5)
    @variable(productOptimizationModel, Product3 >= 0)
    @variable(productOptimizationModel, Product4 >= 0)

    @debug productOptimizationModel

    for resourceRow in DataFrames.eachrow(resourcesTable)

        resourceName = resourceRow[1]
        resourceReserve = resourceRow[columnsCount]
            
        constraintResources = @constraint(productOptimizationModel, 
        Product1 * resourceRow[2] + 
        Product2 * resourceRow[3] + 
        Product3 * resourceRow[4] + 
        Product4 * resourceRow[5] 
        <= resourceReserve
        )
        @debug constraintResources
    end

        functionMax = @objective(productOptimizationModel, Max,
        Product1 * profitRow[2] + 
        Product2 * profitRow[3] + 
        Product3 * profitRow[4] + 
        Product4 * profitRow[5])
        @debug functionMax

    JuMP.optimize!(productOptimizationModel)
    resultStatus = JuMP.termination_status(productOptimizationModel)
    @debug "Optimization status: $resultStatus"
    resultValues = [JuMP.value(Product1), JuMP.value(Product2), JuMP.value(Product3), JuMP.value(Product4)]
    @debug "Optimized product values: $resultValues"

    result  = OptimizationResult(resultStatus, resultValues)
    return result
end

#end module
end
