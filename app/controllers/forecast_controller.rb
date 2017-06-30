class ForecastController < ApplicationController
  before_action :authenticate_request!
  # def new
  #   @forecast_search = Forecasts::SearchService.build
  # end

  def index
    log = Logger.new(STDOUT)
    log.debug(@current_user)
    city = Forecasts::SearchService.random_city(params)
    render :json => city
  end
end
