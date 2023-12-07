# frozen_string_literal: true

class AnswersController < ApplicationController
  before_action :authenticate_user!

  def create
    @question = Question.find(params[:question_id])
    @answer = @question.answers.create(answer_params.merge(author: current_user))

    if @answer.save
      redirect_to @question, notice: t('.success')
    else
      render template: 'questions/show'
    end
  end

  def destroy
    @answer = Answer.find(params[:id])

    if current_user.is_author?(@answer)
      @answer.destroy

      flash[:notice] = t('.delete.success')
    else
      flash[:alert] = t('.delete.fail')
    end

    redirect_to @answer.question
  end

  private

  def answer_params
    params.require(:answer).permit(:body)
  end
end
