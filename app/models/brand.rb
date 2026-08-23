class Brand < ApplicationRecord
	has_many :products, dependent: :nullify

	validates :name, :slug, presence: true
	validates :slug, uniqueness: true
end
