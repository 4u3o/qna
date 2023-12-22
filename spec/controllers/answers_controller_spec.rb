# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  let(:user) { create(:user) }
  let(:question) { create(:question) }

  describe 'POST #create' do
    before { login(user) }

    context 'with valid attributes' do
      it 'creates a new answer' do
        expect { post :create, params: {question_id: question, answer: attributes_for(:answer)}, format: :js }.to change(Answer, :count).by(1)
      end

      before { post :create, params: {question_id: question, answer: attributes_for(:answer)}, format: :js }

      it 'creates a answer for question' do
        expect(assigns(:answer).question).to eq(question)
      end
    end

    context 'with invalid attributes' do
      it 'does not create the answer' do
        expect do
          post :create, params: {question_id: question, answer: attributes_for(:answer, :invalid)}, format: :js
        end.not_to change(Answer, :count)
      end

      it 'renders question/show template' do
        post :create, params: {question_id: question, answer: attributes_for(:answer, :invalid)}, format: :js

        expect(response).to render_template :create
      end
    end
  end

  describe 'DELETE #destroy' do
    let(:author) { create(:user) }
    let!(:answer) { create(:answer, author:, question:) }

    context "when user is a answer's author" do
      before { login(author) }

      it 'delete the answer' do
        expect { delete :destroy, params: {id: answer}, format: :js }.to change(Answer, :count).by(-1)
      end
    end

    context "when user is not a answer's author" do
      let(:not_author) { create(:user) }

      before { login(not_author) }

      it 'not delete the answer' do
        expect { delete :destroy, params: {id: answer}, format: :js }.not_to change(Answer, :count)
      end
    end
  end

  describe 'POST #best' do
    let(:user_question) { create(:question, author: user) }
    let(:answers) { create_list(:answer, 5, question: user_question) }
    let(:target_answer) { answers.sample }

    context 'when user is question author' do
      before { login(user) }

      it 'marks answer as best' do
        post :best, params: {id: target_answer}, format: :js

        expect(assigns(:answer)).to be_best
      end
    end

    context 'when user is not question author' do
      let(:new_user) { create(:user) }

      before { login(new_user) }

      it 'not marks answer as best' do
        post :best, params: {id: target_answer}, format: :js

        expect(assigns(:answer)).to_not be_best
      end
    end
  end
end
