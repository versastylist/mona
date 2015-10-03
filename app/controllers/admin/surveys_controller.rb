class Admin::SurveysController < ApplicationController
  before_action :authenticate_admin!

  def new
    @survey = Survey.new
  end

  def create
    @survey = Survey.new(survey_params)
    @survey.author_id = current_user.id

    if @survey.save
      redirect_to admin_surveys_path, success: "Successfully created survey"
    else
      render :new
    end
  end

  def index
    @surveys = Survey.all.limit(25)
  end

  def show
    @survey = Survey.find(params[:id])
  end

  private

  def survey_params
    params.require(:survey).permit(:title)
  end
end
