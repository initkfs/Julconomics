#!/usr/bin/env julia
#
# Author: initkfs 2019
#
module SimpleFinancial

function fixedProfitabilityRate(securityPrice::BigFloat, securityProfit::BigFloat, periodInYears::BigFloat)::BigFloat

    @assert isfinite(securityPrice)
    @assert securityPrice > 0

    @assert isfinite(securityProfit)
    @assert securityProfit > 0

    @assert securityProfit > securityPrice

    @assert isfinite(periodInYears)
    @assert periodInYears > 0

    profitForInvestor = securityProfit - securityPrice

    securityRate = profitForInvestor / (securityPrice * periodInYears)
    @assert isfinite(securityRate)
    return securityRate
end

function fixedCompoundInterest(amountOfCash::BigFloat, rate::BigFloat, periodInYears::BigFloat)

    @assert isfinite(amountOfCash)
    @assert amountOfCash > 0

    @assert isfinite(rate)
    @assert rate > 0

    @assert isfinite(periodInYears)
    @assert periodInYears > 0

    resultSum = amountOfCash * (1 + rate / 100) ^ periodInYears
    @assert isfinite(resultSum)
    return resultSum    
end

function main()

end

@time main()

end