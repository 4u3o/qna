# frozen_string_literal: true

require 'rails_helper'

feature 'User can view a question and answers' do
  scenario 'see the question and answers' do
    question = create(:question)
    answers = create_list(:answer, 3, question:)

    visit question_path(question)

    expect(page).to have_content question.title
    expect(page).to have_content question.body

    answers.each do |answer|
      expect(page).to have_content answer.body
    end
  end
end
