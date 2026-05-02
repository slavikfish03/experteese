module Api
  class ApiController < ApplicationController
    def next_image
      render_image(step: 1)
    end

    def prev_image
      render_image(step: -1)
    end

    private

    def render_image(step:)
      theme = Theme.find(params[:theme_id])
      images = Image.theme_images(theme.id).order(:id).to_a

      if images.empty?
        render json: { error: "No images for selected theme" }, status: :not_found
        return
      end

      current_index = bounded_index(params[:index].to_i, images.size)
      new_index = (current_index + step) % images.size
      image = images[new_index]

      render json: image_payload(theme, image, new_index, images.size)
    rescue ActiveRecord::RecordNotFound
      render json: { error: "Theme not found" }, status: :not_found
    end

    def bounded_index(index, images_size)
      index.between?(0, images_size - 1) ? index : 0
    end

    def image_payload(theme, image, index, images_size)
      user_value = current_user&.values&.find_by(image: image)

      {
        index: index,
        theme_id: theme.id,
        images_arr_size: images_size,
        image_id: image.id,
        name: image.name,
        file: image.file,
        image_url: helpers.asset_path(image.file),
        values_qty: Value.count,
        common_ave_value: image.ave_value || 0,
        user_valued: user_value.present?,
        value: user_value&.value || 0,
        status: "success"
      }
    end
  end
end
