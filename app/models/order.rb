class Order < ApplicationRecord

  enum method_of_payment: {クレジットカード: 0, 銀行振込: 1}
  enum order_status: {入金待ち: 0, 入金確認: 1, 製作中: 2, 発送準備中: 3, 発送済み: 4}

  belongs_to :customer
  has_many :order_details, dependent: :destroy

  validates :name, presence: true
  validates :postal_code, presence: true
  validates :address, presence: true

  def date_full
    created_at.created_at.strftime('%Y/%m/%d %H:%M:%S')
  end

  def date
    created_at.created_at.strftime('%Y/%m/%d')
  end


end
