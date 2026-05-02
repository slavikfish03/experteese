class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params.dig(:session, :email).to_s.downcase)

    if user&.authenticate(params.dig(:session, :password).to_s)
      sign_in(user)
      redirect_to work_url
    else
      flash.now[:alert] = t("controllers.sessions.login_failed")
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    sign_out
    redirect_to root_url, notice: t("controllers.sessions.signed_out")
  end
end
