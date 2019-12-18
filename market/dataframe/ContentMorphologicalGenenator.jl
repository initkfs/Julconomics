#
# Author: initkfs 2019
#
module ContentMorphologicalGenenator

using DataFrames

function run(contentForm::DataFrames.AbstractDataFrame, contentTypes::DataFrames.AbstractDataFrame)::DataFrames.AbstractDataFrame

    formCopy = copy(contentForm)
    typesCopy = copy(contentTypes)

    formAndTypeTable = DataFrames.join(sort!(contentForm), sort!(contentTypes), kind = :cross)
    
    return formAndTypeTable

end

end