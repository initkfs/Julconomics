#!/usr/bin/env julia
# Author: initkfs 2020
#
module IntegralAnalysisTest

using QuadGK
using Test

function run()

# Working hours = 6
# Labor productivity function = -t^2 + 10t
# Product quantity?

#Q = ∫f(t)dt on [0;6]

y(t) = -t^2 + 10t
productQuantityData::Tuple{AbstractFloat, AbstractFloat} = QuadGK.quadgk(y, 0, 6, rtol=1e-8)
@assert length(productQuantityData) > 1
productQuantity::AbstractFloat = productQuantityData[1]

@test productQuantity == 108

end

@time run()

end
