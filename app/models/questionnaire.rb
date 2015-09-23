# == Schema Information
#
# Table name: questionnaires
#
#  id :integer          not null, primary key
#

class Questionnaire < ActiveRecord::Base
  has_many :questions
end
