class ApplicationController < ActionController::Base
  include Pundit
  before_action :authenticate_user!, except: %i[index show]
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %I[username name avatar])
    devise_parameter_sanitizer.permit(:account_update, keys: %I[username name avatar])
  end 
end
