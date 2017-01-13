class SessionsController < ApplicationController
  layout false

  def create
    @auth = request.env['omniauth.auth']['credentials']
    google = Registration::GoogleService.new @auth['token']
    user = User.find_or_create_by_oauth(google)
    session[:current_user_id] = user.id
    redirect_to root_url
  end
end
