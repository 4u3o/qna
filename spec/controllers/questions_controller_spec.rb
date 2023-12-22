# frozen_string_literal: true

require 'rails_helper'

RSpec.describe QuestionsController, type: :controller do
  let(:question) { create(:question) }
  let(:user) { create(:user) }

  describe 'GET #index' do
    let(:questions) { create_list(:question, 3) }

    before { get :index }

    it 'populates an array of all questions' do
      expect(assigns(:questions)).to match_array(questions)
    end

    it 'renders index view' do
      expect(response).to render_template :index
    end
  end

  describe 'GET #show' do
    before { get :show, params: {id: question} }

    it 'assigns the requested question to @question' do
      expect(assigns(:question)).to eq(question)
    end

    it 'assigns the requested answer to @answer' do
      expect(assigns(:answer)).to be_a_new(Answer).with(question_id: question.id)
    end

    it 'renders show view' do
      expect(response).to render_template :show
    end
  end

  describe 'GET #new' do
    before { login(user) }
    before { get :new }

    it 'assigns the requested question to @question' do
      expect(assigns(:question)).to be_a_new(Question)
    end

    it 'renders new view' do
      expect(response).to render_template :new
    end
  end

  describe 'GET #edit' do
    before { login(user) }
    before { get :edit, params: {id: question}, format: :js }

    it 'assigns the requested question to @question' do
      expect(assigns(:question)).to eq(question)
    end
  end

  describe 'POST #create' do
    context 'when user is authenticated' do
      before { login(user) }

      context 'with valid attributes' do
        it 'creates a new question' do
          expect { post :create, params: {question: attributes_for(:question)} }.to change(Question, :count).by(1)
        end

        it 'redirects to show view' do
          post :create, params: {question: attributes_for(:question)}

          expect(response).to redirect_to assigns(:question)
        end
      end

      context 'with invalid attributes' do
        it 'does not save the question' do
          expect { post :create, params: {question: attributes_for(:question, :invalid)} }.not_to change(Question, :count)
        end

        it 're-renders new view' do
          post :create, params: {question: attributes_for(:question, :invalid)}

          expect(response).to render_template :new
        end
      end
    end

    context 'when user is not authenticated' do
      it 'does not save the question' do
        expect { post :create, params: {question: attributes_for(:question)} }.not_to change(Question, :count)
      end
    end
  end

  describe 'PATCH #update' do
    before { login(user) }

    let(:title_before) { question.title }
    let(:body_before) { question.body }

    context 'with valid attributes' do
      it 'assigns the requested question to @question' do
        patch :update, params: {id: question, question: attributes_for(:question)}, format: :js

        expect(assigns(:question)).to eq(question)
      end

      it 'changes question attributes' do
        patch :update, params: {id: question, question: {title: 'new title', body: 'new body'}}, format: :js
        question.reload

        expect(question.title).to eq(title_before)
        expect(question.body).to eq(body_before)
      end
    end

    context 'with invalid attributes' do
      before { patch :update, params: {id: question, question: attributes_for(:question, :invalid)}, format: :js }

      it 'does not change question' do
        question.reload

        expect(question.title).to eq(title_before)
        expect(question.body).to eq(body_before)
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:question) { create(:question, author: user) }

    context "when user is a question's author" do
      before { login(user) }

      it 'delete the question' do
        expect { delete :destroy, params: {id: question}, format: :js }.to change(Question, :count).by(-1)
      end

      it 'redirect to index' do
        delete :destroy, params: {id: question}

        expect(response).to redirect_to questions_path
      end
    end

    context "when user is not a question's author" do
      let(:not_author) { create(:user) }

      before { login(not_author) }

      it 'not delete the question' do
        expect { delete :destroy, params: {id: question}, format: :js }.not_to change(Question, :count)
      end
    end
  end
end
