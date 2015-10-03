class Admin::QuestionsController < ApplicationController
  def new
    @survey = Survey.find(params[:survey_id])
    build_question
  end

  def create
    @survey = Survey.find(params[:survey_id])
    build_question
    if @question.save
      redirect_to admin_surveys_path, success: 'Successfully added question'
    else
      render :new
    end
  end

  private

  def build_question
    @question = Question.new(question_params)
    @question.build_submittable(type, submittable_params)
    @question.survey = @survey
  end

  def type
    params[:question][:submittable_type]
  end

  def question_params
    params.require(:question).permit(:title)
  end

  def submittable_params
    if params[:question][:submittable_attributes]
      submittable_attrs = params.require(:question).require(:submittable_attributes).permit(
        options_attributes: [:text]
      )
      submittable_attrs
    else
      {}
    end
  end
end
