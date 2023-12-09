# frozen_string_literal: true

require 'rails_helper'

feature 'Logging out' do
  context 'when user authenticated' do
    given(:user) { create(:user) }

    background { sign_in(user) }
    background { visit root_path }

    scenario { expect(page).to have_link log_out }

    scenario 'he logging out' do
      click_on log_out

      expect(page).to have_content 'Signed out successfully.'
      expect(page).not_to have_link log_out
    end
  end

  context 'when user unauthenticated' do
    background { visit root_path }

    scenario { expect(page).not_to have_link log_out }
  end

  private

  def log_out
    I18n.t('partials.nav.log_out')
  end
end
