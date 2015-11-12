# == Schema Information
#
# Table name: surveys
#
#  id         :integer          not null, primary key
#  title      :string           not null
#  author_id  :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Survey < ActiveRecord::Base
  belongs_to :author, class_name: 'User', foreign_key: :author_id
  has_many :questions
  has_many :completions

  delegate :username, to: :author, prefix: true

  validates :title,
    presence: true

  def self.find_or_create_registration_survey(user)
    if user.client?
      find_or_create_client_survey
    elsif user.stylist?
      find_or_create_stylist_survey
    else
      # handle this later/figure out way to refactor
      raise "No registration needed for this type of user.."
    end
  end

  def self.find_or_create_client_survey
    find_by(title: 'Client Registration') || SurveyBuilder.build_client_registration
  end

  def self.find_or_create_stylist_survey
    find_by(title: 'Stylist Registration') || SurveyBuilder.build_stylist_registration
  end

  def self.find_or_create_guest_user_survey
    find_by(title: 'Guest User Search') || SurveyBuilder.build_guest_user_search
  end

  def client_registration?
    title == "Client Registration"
  end

  def stylist_registration?
    title == "Stylist Registration"
  end
end
