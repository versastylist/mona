require 'yaml'

class SurveyBuilder
  def self.build_client_registration
    new.build_client_registration
  end

  def self.build_stylist_registration
    new.build_stylist_registration
  end

  def self.build_guest_user_search
    new.build_guest_user_search
  end

  attr_reader :client_survey, :stylist_survey
  def client_survey
    @client_survey ||= Survey.create(title: "Client Registration", author: admin_user)
  end

  def stylist_survey
    @stylist_survey ||= Survey.create(title: "Stylist Registration", author: admin_user)
  end

  def guest_user_survey
    @guest_user ||= Survey.create(title: "Guest User Search", author: admin_user)
  end

  def build_stylist_registration
    stylist_questions do |question|
      q = Question.new(title: question["title"])
      opts = question["submittable_options"] || {}
      q.build_submittable(question["submittable_type"], opts)
      q.survey = stylist_survey
      q.save!
    end
    stylist_survey
  end

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

  def build_guest_user_search
    guest_user_questions do |question|
      q = Question.new(title: question["title"])
      opts = question["submittable_options"] || {}
      q.build_submittable(question["submittable_type"], opts)
      q.survey = guest_user_survey
      q.save!
    end
    guest_user_survey
  end

  def stylist_questions
    filename = Rails.root.join('db', 'seed_data', 'stylist_registration.yml')
    yaml_file = YAML.load(File.read(filename))
    yaml_file["questions"].each do |question|
      yield question
    end
  end

  def client_questions
    filename = Rails.root.join('db', 'seed_data', 'client_registration.yml')
    yaml_file = YAML.load(File.read(filename))
    yaml_file["questions"].each do |question|
      yield question
    end
  end

  def guest_user_questions
    filename = Rails.root.join('db', 'seed_data', 'guest_user_search.yml')
    yaml_file = YAML.load(File.read(filename))
    yaml_file["questions"].each do |question|
      yield question
    end
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
