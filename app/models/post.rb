
class Post < ApplicationRecord
  belongs_to :user
  belongs_to :sake_log, optional: true
  has_many :likes, dependent: :destroy

  validates :brand, presence: true, length: { maximum: 30 }
  validates :taste, length: { maximum: 20 }
  validates :memo, length: { maximum: 40 }

  scope :search, ->(query) do
    return all if query.blank?
    
    sanitized_query = "%#{query}%"
    where("brand LIKE ? OR taste LIKE ? OR memo LIKE ?", 
          sanitized_query, sanitized_query, sanitized_query)
  end

  scope :recent, -> { order(created_at: :desc) }
end
