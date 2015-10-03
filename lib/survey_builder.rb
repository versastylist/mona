require 'yaml'

class SurveyBuilder
  def self.build_client_registration
    new.build_client_registration
  end

  attr_reader :client_survey
  def build_client_registration
    client_questions do |question|
      q = Question.new(title: question["title"])
      opts = question["submittable_options"] || {}
      q.build_submittable(question["submittable_type"], opts)
      q.survey = client_survey
      q.save!
    end
    client_survey
  end

  def client_questions
    filename = Rails.root.join('db', 'seed_data', 'client_registration.yml')
    yaml_file = YAML.load(File.read(filename))
    yaml_file["questions"].each do |question|
      yield question
    end
  end

  def client_survey
    @client_survey ||= Survey.create(title: "Client Registration", author: admin_user)
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
