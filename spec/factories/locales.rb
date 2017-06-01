FactoryGirl.define do
  factory :ru, class: Locale do
    title 'Русский'
    name 'ru-RU'
  end

  factory :en, class: Locale do
    title 'English'
    name 'en-US'
  end
end
