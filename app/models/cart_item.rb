class CartItem < ApplicationRecord

  belongs_to :customer
  belongs_to :item

  validates :amount, presence: true

  def add_tax_price
    (self.item.price*1.10).round
  end

  def sub_price
    add_tax_price*self.amount
  end
end
