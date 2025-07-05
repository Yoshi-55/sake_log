class Post < ApplicationRecord
  belongs_to :user
  belongs_to :sake_log, optional: true

  validates :body, presence: true, length: { maximum: 1000 }
end
