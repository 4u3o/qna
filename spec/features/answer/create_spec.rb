# frozen_string_literal: true

require 'rails_helper'

feature 'Creating answer for question' do
  given(:user) { create(:user) }
  given(:question) { create(:question) }

  context 'when User is authenticated', js: true do
    background do
      sign_in(user)

      visit question_path(question)
    end

    scenario 'he writes an answer' do
      fill_in 'Your answer', with: 'My answer'
      click_button answer

      expect(page).to have_current_path(question_path(question))
      within '.answers' do
        expect(page).to have_content 'My answer'
      end
    end

    scenario 'he sends empty body' do
      click_button answer

      expect(page).to have_content blank_answer_error
    end
  end

  context 'when User is not authenticated' do
    scenario "he can not see a answer's form" do
      visit question_path(question)

      expect(page).not_to have_button answer
    end
  end

  private

  def answer
    I18n.t('questions.show.answer')
  end

  def blank_answer_error
    "#{Answer.human_attribute_name(:body)} can't be blank"
  end
end
