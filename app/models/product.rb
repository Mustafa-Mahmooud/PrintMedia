class Product < ApplicationRecord
  belongs_to :category
  belongs_to :brand, optional: true
  has_many :product_images, dependent: :destroy
  has_one_attached :image

  scope :active, -> { where(active: true) }
  scope :featured, -> { active.where(featured: true) }

  validates :name, :slug, :short_description, presence: true
  validates :slug, uniqueness: true

  after_initialize :set_defaults, if: :new_record?

  private

  def set_defaults
    self.active = true if active.nil?
    self.featured = false if featured.nil?
  end
end
