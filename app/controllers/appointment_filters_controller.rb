class AppointmentFiltersController < ApplicationController
  def index
    @service_menu = ServiceMenu.find(params[:menu_filter_id])
    @survey = Survey.find_or_create_guest_user_survey
    @questions = @survey.questions

    if params[:query]
      @completion = current_user.completed_survey? ? current_user.registration_survey : temp_completion

      geocoordinates  = find_search_address
      service_ids     = User.available_service_ids(geocoordinates, 5)
      upper_bound     = find_upper_bound

      search_hash = {}
      search_hash[:service_pets]      = true if @completion.has_pets?
      search_hash[:carpet_allergy]    = false if @completion.has_carpet?
      search_hash[:smoker]            = true if @completion.is_smoker?
      search_hash[:medical_condition] = true if @completion.has_medical_condition?
      search_hash[:skin_condition]    = true if @completion.has_skin_condition?
      search_hash[:service_menu]      = [@service_menu.name]
      search_hash[:price]             = { lt: upper_bound }
      search_hash[:service_id]        = service_ids
      search_hash[:displayed]         = true
      search_hash[:stylist_enabled]   = true

      # if !params[:query].blank?
        if current_user.authenticated?
          ProductSearch.create(term: params[:query], client: current_user)
        end

        @service_products = ServiceProductDecorator.decorate_collection(
          ServiceProduct.search(
            params[:query],
            page: params[:page],
            per_page: 10,
            where: search_hash
          )
        )
      # else
        # @service_products = ServiceProductDecorator.decorate_collection(
          # ServiceProduct.displayed.less_than(upper_bound).
          # joins(:service).where(
            # services: { service_menu_id: @service_menu.id }
          # ).where(service_id: service_ids).page(params[:page]).per(10)
        # )
      # end
    end
  end

  private

  def find_upper_bound
    params[:price_range].blank? ? 4000 : params[:price_range].to_i
  end

  def find_search_address
    primary = current_user.primary_address
    return primary.location if primary.present?

    if valid_address
      param_address = TempAddress.new(params[:address]).full_street_address
      Geocoder.coordinates(param_address)
    else
      flash[:danger] = "If you're not registered you need to enter an address to search"
      redirect_to :back
    end
  end

  def valid_address
    !params[:address][:zip_code].blank? && !params[:address][:address].blank?
  end

  def survey_params
    params.require(:survey).permit(answers_attributes: [:text])
  end

  def temp_completion
    comp = Completion.new(survey_params)
    comp.survey = Survey.find_by(title: 'Guest User Search')
    comp.user   = User.admins.first
    comp.save
    comp
  end
end
