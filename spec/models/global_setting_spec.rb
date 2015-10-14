# == Schema Information
#
# Table name: global_settings
#
#  id                 :integer          not null, primary key
#  appointment_buffer :integer
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

require 'rails_helper'

RSpec.describe GlobalSetting, type: :model do
  describe "validations" do
  end
end
