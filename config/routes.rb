# frozen_string_literal: true

Rails.application.routes.draw do
  resources :questions, shallow: true do
    resources :answers, only: %i[new create]
  end
end
