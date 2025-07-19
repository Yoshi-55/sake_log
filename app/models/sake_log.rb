class SakeLog < ApplicationRecord
  belongs_to :user
  has_many :posts, dependent: :nullify

  validates :name, presence: true, length: { maximum: 30 }
  validates :taste, length: { maximum: 20 }
  validates :memo, length: { maximum: 40 }

  scope :recent, -> { order(created_at: :desc) }
end
