class ValuesController < ApplicationController
  before_action :require_sign_in

  def create
    image = Image.find(params[:image_id])
    value = current_user.values.build(image: image, value: params[:value])

    if value.save
      redirect_to work_path(theme_id: image.theme_id), notice: t("controllers.values.submitted")
    else
      redirect_to work_path(theme_id: image.theme_id), alert: value_error_message(value)
    end
  rescue ActiveRecord::RecordNotFound
    redirect_to work_path, alert: t("controllers.values.image_not_found")
  end

  private

  def require_sign_in
    return if signed_in?

    redirect_to login_path, alert: t("controllers.values.require_sign_in")
  end

  def value_error_message(value)
    return t("controllers.values.already_rated") if value.errors.of_kind?(:user_id, :taken)

    value.errors.full_messages.to_sentence
  end
end
