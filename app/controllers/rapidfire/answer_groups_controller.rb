module Rapidfire
  class AnswerGroupsController < Rapidfire::ApplicationController
    before_filter :find_question_group!

    def new
      @answer_group_builder = AnswerGroupBuilder.new(answer_group_params)
    end

    def create
      @answer_group_builder = AnswerGroupBuilder.new(answer_group_params)

      if @answer_group_builder.save
        flash[:success] = "Your answers were submitted successfully!"
        flash.keep(:error)
        redirect_to question_groups_path
      else
        flash[:error] = @answer_group_builder.to_model.errors.full_messages.first #gets error message from model
        flash.keep(:error)
        render :new
      end
    end

    private
    def find_question_group!
      @question_group = QuestionGroup.find(params[:question_group_id])
    end

    def answer_group_params
      answer_params = { params: params[:answer_group] }
      answer_params.merge(user: current_user, question_group: @question_group)
    end
  end
end
