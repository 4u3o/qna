# frozen_string_literal: true

class AnswersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_answer, only: %i[destroy update]

  def create
    @question = Question.find(params[:question_id])
    @answer = @question.answers.create(answer_params.merge(author: current_user))
    flash.now[:success] = t('.create.success')
  end

  def update
    @question = @answer.question
    @answer.update(answer_params)
  end

  def destroy
    @question = @answer.question

    if current_user.author?(@answer)
      @answer.destroy

      flash.now[:notice] = t('.delete.success')
    else
      flash.now[:alert] = t('.delete.fail')
    end
  end


  private

  def set_answer
    @answer = Answer.find(params[:id])
  end

  def answer_params
    params.require(:answer).permit(:body)
  end
end
