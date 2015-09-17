# == Schema Information
#
# Table name: questionnaires
#
#  id :integer          not null, primary key
#

require 'rails_helper'

RSpec.describe Questionnaire, type: :model do
  context "associations" do
    # it { should belong_to(:user) }
    # need to add assocation with stylist later
    it { should have_many(:questions) }
  end
end
