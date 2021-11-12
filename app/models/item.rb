class Item < ApplicationRecord

  validates :name , presence: true
  validates :introduction , presence: true
  validates :price , presence: true
  validates :image , presence: true

  attachment :image

  belongs_to :genre
  has_many :cart_items,dependent: :destroy
  has_many :order_details

  def add_tax_price
    (self.price * 1.10).round
  end

  def self.search_for(content)
    #.orを使用することで、contentに一致するカラムのデータをnameカラムとgenre_idカラムから探してきます。
    Item.where('name LIKE ?', '%'+content+'%').or(Item.where(genre_id: content))
  end

end
