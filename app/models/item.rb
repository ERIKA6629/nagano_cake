class Item < ApplicationRecord
  has_one_attached :image
  has_many :cart_items
  
  validates :image, presence: true
  validates :name, presence: true
  validates :introduction, presence: true
  validates :price, presence: true
end
