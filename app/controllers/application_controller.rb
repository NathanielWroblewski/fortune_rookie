class ApplicationController < ActionController::Base
  before_filter :authenticate_user!

  protect_from_forgery with: :exception

  def not_found
    raise ActionController::RoutingError.new('Not Found')
  end
end
