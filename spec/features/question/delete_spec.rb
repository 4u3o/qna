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

      expect(page).to have_content question_success_deleted
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
    I18n.t('questions.question.delete')
  end

  def question_success_deleted
    I18n.t('questions.destroy.success')
  end
end
