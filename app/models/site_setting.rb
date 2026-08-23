class SiteSetting < ApplicationRecord
	validates :key, presence: true, uniqueness: true

	def self.fetch(key, fallback = nil)
		find_by(key:)&.value.presence || fallback
	end
end
