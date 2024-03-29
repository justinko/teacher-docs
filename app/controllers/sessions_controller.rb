class SessionsController < ApplicationController
  skip_before_action :authenticate, except: :destroy
  before_action :require_no_authentication, except: :destroy

  def new
  end

  def create
    user = User.find_by(email: params[:email])

    if user&.authenticate(params[:password])
      sign_in user
      redirect_to documents_url
    else
      redirect_to new_session_url, alert: t(".invalid")
    end
  end

  def destroy
    Current.session.destroy!
    redirect_to new_session_url
  end
end
