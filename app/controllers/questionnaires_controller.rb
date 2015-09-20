class QuestionnairesController < ApplicationController
  def new
    @user = current_user
    questionnaire_id = params[:questionnaire_id]
    @questionnaire = questionnaire_id ? Questionnaire.find(questionnaire_id) : Questionnaire.new

    if @questionnaire && @questionnaire.questions.any? #need to add completed field
      @questions = @questionnaire.questions
      @answers = []

      @questions.length.times do |i|
        @answers << Answer.new
      end
      render :complete_questionnaire
    end
  end

  def create
    @questionnaire = Questionnaire.new
    if @questionnaire.save
      # redirect_to some_path
      # success
    else
      # errors
      render :new
    end
  end

  def index
    @questionnaires = Questionnaire.all #hard-code, re-factor later
  end

  private

  # def registration_params
  #   params.require(:client_registration).permit(
  #     :first_name,
  #     :last_name,
  #     :phone_number,
  #     :avatar,
  #     :dob,
  #     :gender,
  #     :timezone,
  #     :facebook,
  #     :linked_in
  #   )
  # end
end
