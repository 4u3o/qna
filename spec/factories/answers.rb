# frozen_string_literal: true

FactoryBot.define do
  factory :answer do
    body { Faker::Lorem.paragraph }
    question
    author
  end

  trait :invalid do
    body { nil }
  end
end
