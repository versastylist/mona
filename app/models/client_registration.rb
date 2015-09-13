# == Schema Information
#
# Table name: registrations
#
#  id           :integer          not null, primary key
#  first_name   :string           not null
#  last_name    :string           not null
#  phone_number :string           not null
#  avatar_url   :string
#  dob          :string           not null
#  gender       :string           not null
#  timezone     :string           not null
#  facebook     :string
#  linked_in    :string
#  type         :string
#  user_id      :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class ClientRegistration < Registration
end
