class ApplicationController < ActionController::Base
  before_action :authenticate

  helper_method :authenticated?

  private

  def sign_in(user)
    user_session = user.sessions.create!(
      user_agent: request.user_agent,
      ip_address: request.ip
    )
    cookies.encrypted.permanent[:session_id] = {
      value: user_session.id, httponly: true
    }
  end

  def require_no_authentication
    redirect_to root_url if authenticated?
  end

  def authenticate
    redirect_to new_session_url unless authenticated?
  end

  def authenticated?
    return false unless session_id = cookies.encrypted[:session_id]
    !!(Current.session ||= Session.find_by(id: session_id))
  end
end
