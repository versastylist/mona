# == Schema Information
#
# Table name: service_products
#
#  id                       :integer          not null, primary key
#  name                     :string           not null
#  minute_duration          :integer          not null
#  hours                    :integer
#  minutes                  :integer
#  price                    :decimal(8, 2)    not null
#  details                  :text
#  preparation_instructions :text
#  displayed                :boolean          default(TRUE)
#  service_id               :integer          not null
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#

class ServiceProduct < ActiveRecord::Base
  belongs_to :service
  has_one :service_menu, through: :service
  has_one :stylist, through: :service
  has_many :order_items
  has_many :orders, through: :order_items

  validates :name,
    presence: true
  validates :price,
    presence: true,
    numericality: { greater_than_or_equal_to: 20 }
  validates :minute_duration,
    presence: true,
    numericality: { greater_than_or_equal_to: 30 }

  before_validation :set_minute_duration, unless: :skip_callbacks

  scope :displayed, -> { where(displayed: true) }
  scope :less_than, -> (price) { where('price < ?', price) }
  scope :barber, -> { joins(:service).joins(:service_menu).where(service_menu: { name: 'Barber' }) }

  # Creates these scopes:
  # .hair_cut .weave .blowout_and_sets .natural .barber .makeup .nails .specialties
  ServiceMenu::MENU_NAMES.each do |menu_name|
    scope menu_name.downcase.split.join('_').to_sym, -> {
      joins(:service).where(services: {
        service_menu_id: ServiceMenu.select(:id).where(name: menu_name)
      })
    }
  end

  searchkick

  def search_data
    attributes.merge(
      service_menu: service_menu.name,
      stylist_enabled: stylist.enable_booking,
      serve_pets: completion.serve_pets?,
      carpet_allergy: completion.carpet_allergy?,
      smoker: completion.serve_smoker?,
      medical_condition: completion.serve_medical_condition?,
      skin_condition: completion.serve_skin_condition?
    )
  end

  def completion
    stylist.registration_survey
  end

  private

  def set_minute_duration
    self[:minute_duration] = (hours.hour.to_i + minutes.minute.to_i) / 60
  end
end
