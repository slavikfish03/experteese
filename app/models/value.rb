class Value < ApplicationRecord
  belongs_to :user
  belongs_to :image

  validates :value, numericality: {
    only_integer: true,
    greater_than_or_equal_to: 5,
    less_than_or_equal_to: 100
  }
  validates :user_id, uniqueness: { scope: :image_id }

  after_create :refresh_image_average

  scope :user_valued_image, ->(current_user_id, image_id) {
    where(user_id: current_user_id, image_id: image_id)
  }
  scope :within_twenty_five_percent_of_image_average, -> {
    joins(:image)
      .where("images.ave_value > 0")
      .where("ABS(values.value - images.ave_value) <= images.ave_value * 0.25")
  }

  def self.calc_average_value(image_id)
    values = where(image_id: image_id).pluck(:value)
    return 0 if values.empty?

    (values.sum.to_f / values.size).round
  end

  def deviation_from_image_average
    (value - image.ave_value).abs
  end

  def deviation_percent_from_image_average
    return 0 if image.ave_value.zero?

    ((deviation_from_image_average.to_f / image.ave_value) * 100).round
  end

  private

  def refresh_image_average
    Image.update_ave_value(image_id, Value.calc_average_value(image_id))
  end
end
