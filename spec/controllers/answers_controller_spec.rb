# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  let(:user) { create(:user)}
  let(:question) { create(:question) }

  describe 'POST #create' do
    before { login(user) }

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

  describe 'DELETE #destroy' do
    let(:author) { create(:user) }
    let!(:answer) { create(:answer, author:, question:) }

    context "when user is a answer's author" do
      before { login(author) }

      it 'delete the answer' do
        expect { delete :destroy, params: {id: answer} }.to change(Answer, :count).by(-1)
      end

      it 'redirect to index' do
        delete :destroy, params: {id: answer}

        expect(response).to redirect_to question_path(question)
      end
    end

    context "when user is not a answer's author" do
      let(:not_author) { create(:user) }

      before { login(not_author) }

      it 'not delete the answer' do
        expect { delete :destroy, params: {id: answer} }.not_to change(Answer, :count)
      end
    end
  end
end
