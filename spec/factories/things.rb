require 'faker'

FactoryGirl.define do
  factory :thing do |f|
    f.name { Faker::Lorem.words(1) }
    f.description { Faker::Lorem.sentences(1) }
  end
end
