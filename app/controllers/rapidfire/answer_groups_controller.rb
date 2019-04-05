module Rapidfire
  class AnswerGroupsController < Rapidfire::ApplicationController
    before_action :find_question_group!

    def new
      @answer_group_builder = AnswerGroupBuilder.new(answer_group_params, false)
    end

    def show
      @answer_group_builder = AnswerGroupBuilder.new([answer_group_params, params[:id]], true)
    end

    def create
      @answer_group_builder = AnswerGroupBuilder.new(answer_group_params, false)

      if @answer_group_builder.save
        flash[:success] = "Your answers were submitted successfully!"
        flash.keep(:success)
        UserMailer.survey_completed(@answer_group_builder).deliver
        redirect_to main_app.user_path(current_user)
      else
        if @answer_group_builder.to_model.errors[:user].present? #the user error only comes up if the form input is validated
          flash[:error] = @answer_group_builder.to_model.errors[:user].first #gets error message from model
        end
        #flash.keep(:error)
        render :new
      end
    end

    def destroy
      answer_group = AnswerGroup.find(params[:id])
      if answer_group.destroy
        flash[:success] = "Deleted!"
      end
      redirect_to :back
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
