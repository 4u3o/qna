# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  let(:question) { create(:question) }
  let(:user) { create(:user)}

  describe 'POST #create' do
    before { sign_in(user) }
    context 'with valid attributes' do
      it 'creates a new answer' do
        expect { post :create, params: {question_id: question, answer: attributes_for(:answer)} }.to change(Answer, :count).by(1)
      end

      before { post :create, params: {question_id: question, answer: attributes_for(:answer)} }

      it 'creates a answer for question' do
        expect(assigns(:answer).question).to eq(question)
      end

      it 'redirects to question#show view' do
        expect(response).to redirect_to(question)
      end
    end

    context 'with invalid attributes' do
      it 'does not create the answer' do
        expect do
          post :create, params: {question_id: question, answer: attributes_for(:answer, :invalid)}
        end.not_to change(Answer, :count)
      end

      it 'renders question/show template' do
        post :create, params: {question_id: question, answer: attributes_for(:answer, :invalid)}

        expect(response).to render_template 'questions/show'
      end
    end
  end
end
