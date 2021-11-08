class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :orders, dependent: :destroy
  has_many :order_details, dependent: :destroy
  has_many :addresses, dependent: :destroy
  has_many :cart_items, dependent: :destroy

  validates :first_name , presence: true
  validates :last_name , presence: true
  validates :first_name_kana , presence: true
  validates :last_name_kana , presence: true
  validates :telephone_number , presence: true
  validates :postal_code , presence: true
  validates :address , presence: true
  validates :email , presence: true, length: { maximum: 300 }, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }

  def active_for_authentication?
    super && (is_active == true)
  end

  def full_name
    "#{last_name}#{first_name}"
  end

  def full_kana
    "#{last_name_kana}#{first_name_kana}"
  end
end
