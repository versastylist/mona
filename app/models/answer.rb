# == Schema Information
#
# Table name: answers
#
#  id            :integer          not null, primary key
#  completion_id :integer          not null
#  question_id   :integer          not null
#  text          :string           not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Answer < ActiveRecord::Base
  belongs_to :completion
  belongs_to :question

  after_commit :reindex_service_products, on: :update

  def reindex_service_products
    if completion.user.service_products.present?
      completion.user.service_products.reindex
    end
  end
end
