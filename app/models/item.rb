class Item < ApplicationRecord

  validates :name , presence: true
  validates :introduction , presence: true
  validates :price , presence: true
  validates :is_active , presence: true

  attachment :image

  belongs_to :genre
  has_many :cart_items,dependent: :destroy
  has_many :order_details

  def add_tax_price
    (self.price * 1.10).round
  end

end
