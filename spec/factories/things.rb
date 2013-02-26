require 'faker'

FactoryGirl.define do
  factory :thing do |f|
    f.name { Faker::Lorem.words(1).pop }
    f.description { Faker::Lorem.sentences(1).pop }
  end
end
