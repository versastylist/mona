class UserSerializer < ActiveModel::Serializer
  attributes :username, :first_name, :last_name, :dob, :phone_number
end
