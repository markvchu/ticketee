FactoryGirl.define do

  sequence(:name) {|n| "user#{n}" }
  sequence(:email) {|n| "user#{n}@example.com" }

  factory :user do
    name { generate(:name) }
    email { generate(:email) }
    password 'hunter2'
    password_confirmation 'hunter2'
    factory :admin_user do
      admin true
    end
  end
end