class ApplicationController < ActionController::Base
  before_filter :authenticate_user!

  protect_from_forgery with: :exception

  def not_found
    raise ActionController::RoutingError.new('Not Found')
  end

  def integerize(price)
    price.gsub!('$', '')
    price.gsub!(',', '')
    if price.match(/\.\d{2}/)
      price.gsub!('.', '').to_i
    elsif price.match(/\.\d{1}/)
      price << '0'
      price.gsub!('.', '').to_i
    elsif price.match(/\./).nil?
      price << '00'
      price.gsub!('.', '').to_i
    end
  end
end
