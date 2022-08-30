class ApplicationController < ActionController::Base
  before_action :set_cart
  include Pagy::Backend

  def set_cart
    cookies[:cart] = [].to_json if cookies[:cart].blank?
  end
end
