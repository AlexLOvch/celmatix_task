# frozen_string_literal: true
FactoryGirl.define do
  factory :brand do
    name { Faker::Company.name }
  end
end
