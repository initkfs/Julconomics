#!/usr/bin/env julia
#
# Author: initkfs 2019
#
module DigitalMarketingIndicators

struct ActiveUsersData
    dailyActiveUsersDAU::Int
    weeklyActiveUsersWAU::Int
    monthlyActiveUsersMAU::Int
end

struct UsersOnlineData
    #users in the application at a certain moment
    сonсurrentUsersCCU::Int
    #maximum number of users simultaneously in the application.
    peakConcurrentUsersPCCU::Int
end

function uniNumbersRatio(x::N1, y::N2)::BigFloat where {N1<:Number, N2<:Number}

    if(isa(x, AbstractFloat))
        @assert isfinite(x)
    end

    if(isa(y, AbstractFloat))
        @assert isfinite(y)
    end

    if(y == 0)
        return 0
    end

    numbersRatio = x / y
    @assert isfinite(numbersRatio)
    return numbersRatio

end

function weeklyStickyFactorPercentSF(dailyActiveUsersDAU::Int, weeklyActiveUsersWAU::Int)::BigFloat
    stickyFactorPercent = uniNumbersRatio(dailyActiveUsersDAU, weeklyActiveUsersWAU) * 100
    return stickyFactorPercent
end

function monthlyStickyFactorPercentSF(dailyActiveUsersDAU::Int, monthlyActiveUsersMAU::Int)::BigFloat
    stickyFactorPercent = uniNumbersRatio(dailyActiveUsersDAU, monthlyActiveUsersMAU) * 100
    return stickyFactorPercent
end

function averageRevenuePerUserARPU(revenue::BigFloat, totalUsers::Int)::BigFloat

    arpu = uniNumbersRatio(revenue, totalUsers)
    return arpu

end

function averageRevenuePerPayingUserARPPU(revenue::BigFloat, payingUsers::Int)::BigFloat

    arppu = uniNumbersRatio(revenue, payingUsers)
    return arppu

end

function averageOrderValueAOV(revenue::BigFloat, ordersCount::Int)::BigFloat

    aov = uniNumbersRatio(revenue, ordersCount)
    return aov

end

function churnRatePercent(usersInPeriodStart::Int, usersInPeriodEnd::Int)::BigFloat

    usersDiff = usersInPeriodStart - usersInPeriodEnd
    churnRatePercent = uniNumbersRatio(usersDiff, usersInPeriodStart) * 100
    return churnRatePercent

end

function payingUsersRatePercent(payingUsersCount::Int, activeUsers::Int)::BigFloat

    payingUsersPercent = uniNumbersRatio(payingUsersCount, activeUsers) * 100
    return payingUsersPercent

end

#users who paid immediately after installation / users who installed the application
function payingUsersConversion(paidAfterInstallUsers::Int, newUsers::Int)::BigFloat

    @assert newUsers >= paidAfterInstallUsers

    payingUsersPercent = uniNumbersRatio(paidAfterInstallUsers, newUsers) * 100
    return payingUsersPercent

end

function returnOnInvestmentPercentROI(revenue::BigFloat, investment::BigFloat)::BigFloat

    roiPercent = uniNumbersRatio(revenue, investment) * 100
    return roiPercent

end

end