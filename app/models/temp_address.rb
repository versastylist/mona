class TempAddress
  attr_reader :address, :zip_code, :state, :city, :appt_num
  def initialize(params)
    @address  = params[:address]
    @zip_code = params[:zip_code]
    @state    = params[:state]
    @city     = params[:city]
    @appt_num = params[:appt_num]
  end

  def full_street_address
    [address, appt_num, city, state, zip_code].join(', ')
  end
end
