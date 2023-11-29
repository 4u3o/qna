# frozen_string_literal: true

class AnswersController < ApplicationController
  before_action :set_question, only: %i[new create]

  def new
    # не уверен что этот экшен понадобиться, скорее всего форма будет на странице вопроса
    @answer = @question.answers.create
  end

  def create
    @answer = @question.answers.create(answer_params)

    if @answer.save
      redirect_to @question
    else
      render :new
    end
  end

  private

  def set_question
    @question = Question.find(params[:question_id])
  end

  def answer_params
    params.require(:answer).permit(:body)
  end
end
