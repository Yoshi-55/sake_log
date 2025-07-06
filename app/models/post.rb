
class Post < ApplicationRecord
  belongs_to :user
  belongs_to :sake_log, optional: true
  has_many :likes, dependent: :destroy

  validates :brand, presence: true, length: { maximum: 30 }
  validates :taste, length: { maximum: 20 }
  validates :memo, length: { maximum: 40 }
end
