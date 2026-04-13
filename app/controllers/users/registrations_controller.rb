class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_account_update_params, only: [:update]

  protected

  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: [:avatar, :name])
  end

  def after_update_path_for(resource)
    edit_user_registration_path
  end
end
