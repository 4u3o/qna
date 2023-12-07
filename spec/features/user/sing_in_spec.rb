# frozen_string_literal: true

require 'rails_helper'

feature 'User can sign in', "
  In order to ask questions
  As an unauthenticated user
  I'd like to be able to sign in
" do
  given(:user) { create(:user) }

  background { visit new_user_session_path }

  scenario 'registered user tries to sign in' do
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button log_in

    expect(page).to have_content 'Signed in successfully.'
  end

  scenario 'unregistered user tries to sign in' do
    fill_in 'Email', with: 'wrong@test.com'
    fill_in 'Password', with: '12345678'
    click_button log_in

    expect(page).to have_content 'Invalid Email or password.'
  end

  private

  def log_in
    I18n.t('partials.nav.log_in')
  end
end
