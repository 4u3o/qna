# frozen_string_literal: true

require 'rails_helper'

feature 'Answer deleting' do
  given!(:answer_author) { create(:user) }
  given!(:question_author) { create(:user) }
  given!(:question) { create(:question, author: question_author) }
  given!(:answer) { create(:answer, question:, author: answer_author) }

  context "when user is an answer's author" do
    background { sign_in(answer_author) }

    scenario 'he deletes an answer' do
      visit question_path(question)

      click_link delete_answer

      expect(page).to have_content 'Answer was successfully deleted.'
    end
  end

  context "when user is not answer's author" do
    background { sign_in(question_author) }

    scenario do
      visit question_path(question)

      expect(page).not_to have_link delete_answer
    end
  end

  private

  def delete_answer
    'Delete answer'
  end
end
