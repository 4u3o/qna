# frozen_string_literal: true

require 'rails_helper'

feature 'User can view the list of questions' do
  context 'when 5 questions created' do
    scenario 'he sees 5 titles' do
      questions = create_list(:question, 5)

      visit questions_path

      questions.each do |question|
        expect(page).to have_content question.title
      end
    end
  end
end
