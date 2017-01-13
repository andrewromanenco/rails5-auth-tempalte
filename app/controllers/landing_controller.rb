class LandingController < ApplicationController
  layout false

  def index
    @logged_in = session.has_key? :current_user_id
  end
end
