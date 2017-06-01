FactoryGirl.define do
  factory :user, class: User do
    email 'johndoe@gmail.com'
    password '1qazXSW@'
    locale_id 1
  end
end
