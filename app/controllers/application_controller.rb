class ApplicationController < ActionController::Base
  before_action :authenticate_user!, except: [:top, :about]
  before_action :configure_permitted_parameters, if: :devise_controller?
  
  # ログイン,サインイン
  def after_sign_in_path_for(resource)
    flash[:notice] = "Signed in successfully."
    user_path(@user.id)
  end
  
  # ログアウト
  def after_sign_out_path_for(resource)
     flash[:notice] = "Signed out successfully."
     root_path
  end

  protected

  def configure_permitted_parameters
    # サインアップ時に名前のパラメータを許可
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email])
  end
end