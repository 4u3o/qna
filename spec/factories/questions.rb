# frozen_string_literal: true

FactoryBot.define do
  sequence(:title) { |n| "My title #{n}" }

  factory :question do
    title
    body { 'MyText' }
    author

    trait :invalid do
      title { nil }
    end
  end
end
