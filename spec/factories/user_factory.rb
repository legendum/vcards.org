FactoryGirl.define do

  factory :user do
    country "en"
    plan "free"
    state "active"

    sequence :email do |n|
      "fred#{n}@gmail.com"
    end

    config Hash.new(
      time_zone: 0,
    )

    trait :backer do
      plan "backer"
    end

    trait :suspended do
      state "suspended"
    end

    factory :"user/pro", class: "User", traits: [:pro]
    factory :"user/suspended", class: "User", traits: [:suspended]
  end
end
