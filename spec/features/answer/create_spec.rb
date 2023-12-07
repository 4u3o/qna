# frozen_string_literal: true

require 'rails_helper'

feature 'Creating answer for question' do
  given(:user) { create(:user) }
  given(:question) { create(:question) }

  context 'when User is authenticated' do
    background do
      sign_in(user)

      visit question_path(question)
    end

    scenario 'he writes an answer' do
      fill_in 'Body', with: 'My answer'
      click_button answer

      expect(page).to have_content 'My answer'
    end

    scenario 'he sends empty body' do
      click_button answer

      expect(page).to have_content "Body can't be blank"
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
end
