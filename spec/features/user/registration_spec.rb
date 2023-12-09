# frozen_string_literal: true

require 'rails_helper'

feature 'Registration' do
  background { visit new_user_registration_path }

  scenario 'user fills in valid information' do
    fill_in 'Email', with: 'myemail@example.com'
    fill_in 'Password', with: '123qwe'
    fill_in 'Password confirmation', with: '123qwe'

    click_button 'Sign up'

    expect(page).to have_content 'Welcome! You have signed up successfully.'
  end

  # кажется, что негативные сценарии тут обрабатывает девайс
end
