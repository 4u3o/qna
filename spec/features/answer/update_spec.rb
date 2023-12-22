# frozen_string_literal: true

require 'rails_helper'

feature 'User can edit his answer', "
  In order to correct mistakes
  As an author of answer
  I'd like ot be able to edit my answer
" do

  given!(:user) { create(:user) }
  given!(:question) { create(:question) }
  given!(:answer) { create(:answer, question:, author: user) }

  scenario 'Unauthenticated can not edit answer' do
    visit question_path(question)

    expect(page).to_not have_link 'Edit'
  end

  describe 'Authenticated user', js: true do
    background do
      sign_in user
      visit question_path(question)

      click_link edit_answer
    end

    scenario 'edits his answer' do
      within '.answers' do
        fill_in 'Your answer', with: 'edited answer'
        click_button save_answer

        expect(page).to_not have_content answer.body
        expect(page).to have_content 'edited answer'
        expect(page).to_not have_selector 'textarea'
      end
    end

    scenario 'edits his answer with errors' do
      within '.answers' do
        fill_in 'Your answer', with: ''
        click_button save_answer

        within '.answer-update-errors' do
          expect(page).to have_content blank_answer_error
        end
      end
    end
  end

  private

  def blank_answer_error
    "#{Answer.human_attribute_name(:body)} can't be blank"
  end

  def edit_answer
    I18n.t('answers.answer.edit')
  end

  def save_answer
    I18n.t('answers.answer.save')
  end
end