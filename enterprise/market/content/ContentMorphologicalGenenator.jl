#
# Author: initkfs 2019
#
module ContentMorphologicalGenenator

using DataFrames

function run(contentForm::DataFrames.AbstractDataFrame, contentTypes::DataFrames.AbstractDataFrame, contentTarget::DataFrames.AbstractDataFrame, contentTonality::DataFrames.AbstractDataFrame)::DataFrames.AbstractDataFrame

    targetAndTonalityTable = DataFrames.join(contentTarget, contentTonality, kind = :cross)

    formAndTypeTable = DataFrames.join(contentForm, contentTypes, kind = :cross)
    
    resultTable = DataFrames.join(targetAndTonalityTable, formAndTypeTable, kind = :cross)
    return resultTable

end

end