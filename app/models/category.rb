class Category < ApplicationRecord
	has_many :products, dependent: :restrict_with_error
	has_one_attached :image

	validates :name, :slug, presence: true
	validates :slug, uniqueness: true
end
