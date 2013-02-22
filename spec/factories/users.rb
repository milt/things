require 'faker'

FactoryGirl.define do
  factory :user do |f|
    f.email { Faker::Internet.email }
    f.password 'changeme'
    f.password_confirmation 'changeme'
    # required if the Devise Confirmable module is used
    # confirmed_at Time.now

  
    factory :admin do
      after(:create) {|user| user.add_role :admin }
    end
  end
end