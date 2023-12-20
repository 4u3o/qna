# frozen_string_literal: true

require 'rails_helper'

feature "Question updating" do
  given!(:user) { create(:user) }
  given!(:question) { create(:question, author: user) }
  given!(:not_authored_question) { create(:question) }

  context 'when user is authenticated' do
    background do
      sign_in(user)
    end

    context "when user is question's author", js: true do
      scenario 'he updates the body' do
        visit question_path(question)
        click_link edit_question
        fill_in 'Body', with: 'Updated question'
        click_button save_question

        expect(page).to have_content 'Updated question'
        expect(page).to have_content 'Your question was successfully updated'
      end
    end

    context "when user is not question's author" do
      scenario do
        visit question_path(not_authored_question)

        expect(page).to_not have_link edit_question
      end
    end
  end

  context "when user is not authenticatec" do
    scenario 'he visit question page' do
      visit question_path(question)

      expect(page).to_not have_link edit_question
    end
  end

  private

  def edit_question
    "Edit question"
  end

  def save_question
    "Update Question"
  end
end
