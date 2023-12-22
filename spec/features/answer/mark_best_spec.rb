# frozen_string_literal: true

require 'rails_helper'

feature 'User can mark answer as best' do
  given!(:user) { create(:user) }
  given!(:question) { create(:question, author: user) }
  given!(:answers) { create_list(:answer, 3, question:) }

  context 'when user is authenticated' do
    context 'when he is question author' do
      scenario 'he marks answer as best', js: true do
        target_answer = answers[1]

        sign_in(user)
        visit question_path(question)
        click_link mark_best, href: best_answer_path(target_answer)

        answers = all('.answer')

        expect(answers.first).to have_content target_answer.body
      end
    end

    context 'when he is not question answer' do
      given(:new_user) { create(:user) }

      scenario 'he can not see mark button' do
        sign_in(new_user)
        visit question_path(question)

        expect(page).to_not have_link mark_best
      end
    end
  end

  private

  def mark_best
    I18n.t('answers.answer.mark_best')
  end
end
