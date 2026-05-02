class WorkController < ApplicationController
  def index
    @themes = Theme.joins(:images).distinct.order(:name)
    @selected_theme = selected_theme
    @images = @selected_theme ? Image.theme_images(@selected_theme.id).order(:id) : Image.none
    @current_image = @images.first
    @values_qty = Value.count
  end

  private

  def selected_theme
    return @themes.first if params[:theme_id].blank?

    @themes.find_by(id: params[:theme_id]) || @themes.first
  end
end
