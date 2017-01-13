module UserAwared
  extend ActiveSupport::Concern

  included do
    before_action :lookup_user
    helper_method :is_user_logged_in?
  end

  def user
    @user
  end

  def is_user_logged_in?
    @user != nil
  end

  private

  def lookup_user
    return nil unless session.has_key? :current_user_id
    @user = User.find_by_id(session[:current_user_id])
  end
end
