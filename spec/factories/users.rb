FactoryBot.define do

  factory :user do
    nickname              {"nickname"}
    email                 {"email@gmail.com"}
    password              {"1234567"}
    password_confirmation {"1234567"}
    lastname_kanji        {"lastname_kanji"}
    firstname_kanji       {"firstname_kanji"}
    lastname_kana         {"lastname_kana"}
    firstname_kana        {"firstname_kanaZ"}
    birthday              {"1234-01-01"}
    cellphone_number      {"01234567"}
  end

end