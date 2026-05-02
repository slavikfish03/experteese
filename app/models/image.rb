class Image < ApplicationRecord
  belongs_to :theme
  has_many :values, dependent: :destroy

  validates :name, presence: true
  validates :file, presence: true, uniqueness: true
  validates :ave_value, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  scope :theme_images, ->(theme_id) { where(theme_id: theme_id) }

  def self.find_image(image_id)
    find(image_id)
  end

  def self.update_ave_value(image_id, ave_value)
    find(image_id).update!(ave_value: ave_value)
  end
end
