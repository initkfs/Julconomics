#!/usr/bin/env julia
# Author: initkfs 2020
#
module LinearEquationTest

using LinearAlgebra

#Product type | Selling method | Number of required sales
#             | 1   2   3      |
#--------------------------------------------------------
#А            | 3   2   1      |   350
#B            |	1   6   2      |   290
#C            |	4   1   5      |   665

function run()

    coefficientMatrix = [3 2 1; 1 6 2; 4 1 5]
    salesCount = [360; 300; 675]

    #Rouche–Capelli function?
    coefficientMatrixRank = LinearAlgebra.rank(coefficientMatrix)

    augmentedMatrix = hcat(coefficientMatrix, salesCount)
    augmentedMatrixRank = LinearAlgebra.rank(augmentedMatrix)
    @assert coefficientMatrixRank == augmentedMatrixRank

    solutionMatrix = coefficientMatrix \ salesCount

    x,y,z = solutionMatrix

    @assert 3x + 2y + z == salesCount[1]
    @assert x + 6y + 2z == salesCount[2]
    @assert 4x + y + 5z == salesCount[3]

end

@time run()

end
