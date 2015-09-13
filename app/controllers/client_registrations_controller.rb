class ClientRegistrationsController < ApplicationController
  def new
    @registration = ClientRegistration.new
  end

  def create
    binding.pry
  end
end
