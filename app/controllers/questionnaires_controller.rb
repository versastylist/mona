class QuestionnairesController < ApplicationController
  def new
    # @user = current_user
    @questionnaire = Questionnaire.new
  end

  def create
    @questionnaire = Questionnaire.new

    if @questionnaire.save
      redirect_to #some_path
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
