# frozen_string_literal: true

require 'rails_helper'

feature 'Showing question and answers' do
  given(:question) { create(:question) }
  given!(:answers) { create_list(:answer, 3, question:) }

  background { visit question_path(question) }

  scenario 'user is viewing the question' do
    expect(page).to have_content question.title
    expect(page).to have_content question.body
  end

  scenario 'user is viewing answers' do
    answers.each do |answer|
      expect(page).to have_content answer.body
    end
  end
end
