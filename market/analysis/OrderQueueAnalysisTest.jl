#!/usr/bin/env julia
# Author: initkfs 2020
#
module OrderQueueProbabilityAnalysisTest

using Distributions

function toPercent(x::N)::Float64 where {N<:Number}
    return round(x * 100, digits = 2)
end

function run()

    orderFlowRatePerSec = 1.5
    timeForAnalysisSec = 2
    serviceTimeForOrderSec = 0.2
    serviceIntensitySec =  1 / serviceTimeForOrderSec

    flowForAnalysisSec = orderFlowRatePerSec * timeForAnalysisSec
    distribution = Distributions.Poisson(flowForAnalysisSec)

    minOrders = 0
    maxOrders = 2
    println("Probability density for orders:")
    for i = minOrders:maxOrders
        probabilityDensity = Distributions.pdf(distribution, i)
        println("$i order(s): $(toPercent(probabilityDensity))%")
    end

    moreOneOrder = 1 - Distributions.pdf(distribution, 1)
    println("Probability of at least one order: $(toPercent(moreOneOrder))%")

    relativeQueueThroughputSec = serviceIntensitySec / (orderFlowRatePerSec + serviceIntensitySec)
    probabilityOfFailure = orderFlowRatePerSec / (orderFlowRatePerSec + serviceIntensitySec)
    absoluteQueueThroughputSec = orderFlowRatePerSec * relativeQueueThroughputSec

    println("$(toPercent(relativeQueueThroughputSec))% orders will be served")
    println("$(round(absoluteQueueThroughputSec, digits = 2)) orders will be served per second")
    println("Queue failure probability: $(round(probabilityOfFailure, digits = 2))")

end

@time run()

end
