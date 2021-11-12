class Genre < ApplicationRecord

  has_many :items, dependent: :destroy
  validates :name , presence: true
  # attachment :image

end
