class Theme < ApplicationRecord
  has_many :images, dependent: :restrict_with_error

  validates :name, presence: true, uniqueness: true

  def self.find_theme_id(theme_name)
    find_by!(name: theme_name).id
  end
end
