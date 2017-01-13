class SessionsController < ApplicationController
  layout false

  def new
  end

  def create
    @auth = request.env['omniauth.auth']['credentials']
    google = Registration::GoogleService.new @auth['token']
    @name = google.full_name
  end
end
