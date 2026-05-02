class ApplicationController < ActionController::Base
  include SessionsHelper

  before_action :set_locale

  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  # Changes to the importmap will invalidate the etag for HTML responses
  stale_when_importmap_changes

  def default_url_options
    { locale: I18n.locale }
  end

  private

  def set_locale
    requested_locale = params[:locale]&.to_sym

    if requested_locale.in?(I18n.available_locales)
      session[:locale] = requested_locale
    end

    I18n.locale = session[:locale] || I18n.default_locale
  end
end
