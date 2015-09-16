# == Schema Information
#
# Table name: addresses
#
#  id         :integer          not null, primary key
#  primary    :boolean          default(FALSE)
#  user_id    :integer          not null
#  address    :string           not null
#  zip_code   :string           not null
#  state      :string           not null
#  appt_num   :string
#  city       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Address < ActiveRecord::Base
  belongs_to :user

  validates_presence_of :address,
    :zip_code, :city, :state, :primary
end
