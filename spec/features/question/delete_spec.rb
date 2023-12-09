# frozen_string_literal: true

require 'rails_helper'

feature 'Question deleting' do
  given!(:author) { create(:user) }
  given!(:not_author) { create(:user) }
  given!(:question) { create(:question, author:) }

  context "when user is a question's author" do
    background { sign_in(author) }

    scenario 'he deletes a question' do
      visit question_path(question)

      click_link delete_question

      expect(page).to have_content 'Question was successfully deleted.'
    end
  end

  context "when user is not question's author" do
    background { sign_in(not_author) }

    scenario do
      visit question_path(question)

      expect(page).not_to have_link delete_question
    end
  end

  private

  def delete_question
    I18n.t('questions.show.delete_button')
  end
end
