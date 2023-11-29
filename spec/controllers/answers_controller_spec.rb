# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  let(:question) { create(:question) }

  describe 'GET #new' do
    before { get :new, params: {question_id: question} }

    it 'assigns the requested answer to @answer' do
      expect(assigns(:answer)).to be_a_new(Answer).with(question_id: question.id)
    end

    it 'renders new view' do
      expect(response).to render_template :new
    end
  end

  describe 'POST #create' do
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

      it 're-renders new view' do
        post :create, params: {question_id: question, answer: attributes_for(:answer, :invalid)}

        expect(response).to render_template :new
      end
    end
  end
end
