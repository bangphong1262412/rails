class Pet < ApplicationRecord
  belongs_to :user
  belongs_to :category

  has_many :costs
  has_many_attached :pet_photos
  accepts_nested_attributes_for :costs
  has_rich_text :pet_description
end
