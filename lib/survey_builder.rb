class SurveyBuilder
  def self.build_client_registration
    new.build_client_registration
  end

  attr_reader :client_survey
  def build_client_registration
    client_survey
    children?
    pets?
    smoker?
    carpeted?
    medical?
    skin?
    client_survey
  end

  def client_survey
    @client_survey ||= Survey.create(title: "Client Registration", author: admin_user)
  end

  def children?
    question = Question.new(title: 'Would you use this service for your children?')
    question.build_submittable('ConfirmSubmittable', {})
    question.survey = client_survey
    question.save!
  end

  def pets?
    question = Question.new(title: 'Do you have pets?')
    question.build_submittable('ConfirmSubmittable', {})
    question.survey = client_survey
    question.save!
  end

  def smoker?
    question = Question.new(title: 'Are you a smoker?')
    question.build_submittable('ConfirmSubmittable', {})
    question.survey = client_survey
    question.save!
  end

  def carpeted?
    question = Question.new(title: 'Is your place carpeted?')
    question.build_submittable('ConfirmSubmittable', {})
    question.survey = client_survey
    question.save!
  end

  def medical?
    question = Question.new(title: 'Do you have any current medical conditions?')
    question.build_submittable('ConfirmSubmittable', {})
    question.survey = client_survey
    question.save!
  end

  def skin?
    question = Question.new(title: 'Do you have any current skin conditions?')
    question.build_submittable('ConfirmSubmittable', {})
    question.survey = client_survey
    question.save!
  end

  def admin_user
    if User.admins.present?
      User.admins.first
    else
      create_admin
    end
  end

  private

  def create_admin
    User.create(
      username: "admin",
      email: "admin@email.com",
      password: "password",
      password_confirmation: "password",
      role: "admin",
      agree_to_terms: true
    )
  end
end
