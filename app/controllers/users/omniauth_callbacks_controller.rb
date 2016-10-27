require 'pry'
class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def facebook

    @user = User.from_omniauth(request.env["omniauth.auth"])
    @user.update_attribute(:image, env["omniauth.auth"]["info"]["image"])
    @user.update_attribute(:name, env["omniauth.auth"]["info"]["name"])
    sign_in_and_redirect @user
  end
end
