# == Schema Information
#
# Table name: questionnaires
#
#  id :integer          not null, primary key
#

class Questionnaire < ActiveRecord::Base
  # belongs_to :user
  has_many :questions
  # accepts_nested_attributes_for :questions, :reject_if => lambda { |a| a[:content].blank? }, :allow_destroy => true

  # validates :user,
  #   presence: true
end
