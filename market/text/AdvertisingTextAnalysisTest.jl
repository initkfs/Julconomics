#!/usr/bin/env julia
#
# Author: initkfs 2020
#
module AdvertisingTextAnalysisTest

#add TextAnalysis.jl#master
using TextAnalysis
using Languages

function createDocument(text::String, language::Languages.Language = TextAnalysis.Languages.Russian())::AbstractDocument

     stringDocument = TextAnalysis.StringDocument(text)
     
     TextAnalysis.language!(stringDocument, language)
     TextAnalysis.remove_corrupt_utf8!(stringDocument)
     
     return stringDocument
end

function main()

     #TODO extract texts
     aidaModelTexts = "Хочешь на 200%? Узнай больше о нашей программе и начни зарабатывать уже сегодня!. Только сегодня – скидка 50%. Купи сейчас и получи второй экземпляр в подарок. Бесплатный онлайн мастер-класс. Заполни форму и получи цены, фото бесплатно! Без предоплаты. Гарантия на ремонт. Минимальный опыт работы сотрудников — 5 лет"

     accaModelTexts = "Каждому клиенту — дизайн-проект в подарок. При обращении к нам опытный специалист составит проект. Он учтет все ваши пожелания. Так выглядят обычный и профессиональный проект. При этом стоимость одинаковая! Посмотрите примеры работ."

     #other classifiers https://alan-turing-institute.github.io/MLJ.jl/stable/
     model = TextAnalysis.NaiveBayesClassifier([:aida, :acca])
     
     TextAnalysis.fit!(model, aidaModelTexts, :aida)
     TextAnalysis.fit!(model, accaModelTexts, :acca)

     probableRating = TextAnalysis.predict(model, "Регистрируйся на сайте и сразу начинай!")
     
     #Dict(:acca => 0.16043694287860133,:aida => 0.8395630571213987)
     println(probableRating)
end

@time main()

end
