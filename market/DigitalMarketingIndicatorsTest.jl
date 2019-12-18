#!/usr/bin/env julia
#
# Author: initkfs 2019
#
module DigitalMarketingIndicatorsTest

include("$(@__DIR__)/DigitalMarketingIndicators.jl")

using .DigitalMarketingIndicators
using Test

function roundDefault(x::N)::Float64 where {N<:Number}
    return round(x, Base.Rounding.RoundNearestTiesUp, digits = 4)
end

function main()

    activeUsersData = DigitalMarketingIndicators.ActiveUsersData(100, 200, 500)

    monthlyStickyFactor = DigitalMarketingIndicators.monthlyStickyFactorPercentSF(activeUsersData.dailyActiveUsersDAU, activeUsersData.monthlyActiveUsersMAU)
    @test roundDefault(monthlyStickyFactor) == 20

    weeklyStickyFactor = DigitalMarketingIndicators.weeklyStickyFactorPercentSF(activeUsersData.dailyActiveUsersDAU, activeUsersData.weeklyActiveUsersWAU)
    @test roundDefault(weeklyStickyFactor) == 50

    revenue = big(1000.0)

    totalUsers = 5000
    arpu = DigitalMarketingIndicators.averageRevenuePerUserARPU(revenue, totalUsers)
    @test roundDefault(arpu) == 0.2

    payingUsers = 2500
    arppu = DigitalMarketingIndicators.averageRevenuePerPayingUserARPPU(revenue, payingUsers)
    @test  roundDefault(arppu) == 0.4

    orderCount = 2600
    aov = DigitalMarketingIndicators.averageOrderValueAOV(revenue, orderCount)
    @test roundDefault(aov) == 0.3846

    usersInPeriodStart = 200
    usersInPeriodEnd = 180
    churnRatePercent = DigitalMarketingIndicators.churnRatePercent(usersInPeriodStart, usersInPeriodEnd)
    @test roundDefault(churnRatePercent) == 10

    payingUsers = 100
    activeUsers = 200
    payingUsersPercent = DigitalMarketingIndicators.payingUsersRatePercent(payingUsers, activeUsers)
    @test roundDefault(payingUsersPercent) == 50

    newUsers = 200
    payingUsersConversion = DigitalMarketingIndicators.payingUsersConversion(payingUsers, newUsers)
    @test payingUsersConversion == 50 

    investment = big(6000.0)
    roi = DigitalMarketingIndicators.returnOnInvestmentPercentROI(revenue, investment)
    @test roundDefault(roi) == 16.6667

end

@time main()

end