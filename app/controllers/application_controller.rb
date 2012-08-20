class ApplicationController < ActionController::Base
  protect_from_forgery
  
  def invalid_query
    raise ActionController::RoutingError.new('Not Found')
  end
end
