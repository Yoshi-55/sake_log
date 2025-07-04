class SakeLog < ApplicationRecord
  belongs_to :user

  validates :name, presence: true, length: { maximum: 30 }
  validates :taste, length: { maximum: 20 }
  validates :memo, length: { maximum: 80 }
end
