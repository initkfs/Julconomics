#
# Author: initkfs 2019
#
module ContentMorphologicalGenenator

using DataFrames

function run(contentForm::DataFrames.AbstractDataFrame, contentTypes::DataFrames.AbstractDataFrame)::DataFrames.AbstractDataFrame

    contentFormCopy = copy(contentForm)
    contentTypesCopy = copy(contentTypes)

    formAndTypeTable = DataFrames.join(sort!(contentFormCopy), sort!(contentTypesCopy), kind = :cross)
    
    return formAndTypeTable

end

end