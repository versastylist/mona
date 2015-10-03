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

  def self.find_or_create_registration_survey(user)
    if user.client?
      find_by(title: 'Client Registration') || SurveyBuilder.build_client_registration
    elsif user.stylist?
      find_by(title: 'Stylist Registration') || SurveyBuilder.build_stylist_registration
    else
      # handle this later/figure out way to refactor
      raise "No registration needed for this type of user.."
    end
  end
end
