# frozen_string_literal: true

FactoryBot.define do
  factory :answer do
    body { 'MyText' }
    question
    author
  end

  trait :invalid do
    body { nil }
  end
end
