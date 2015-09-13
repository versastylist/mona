# == Schema Information
#
# Table name: questionnaires
#
#  id      :integer          not null, primary key
#  user_id :integer
#

class Questionnaire < ActiveRecord::Base
  belongs_to :user
  has_many :questions
end
