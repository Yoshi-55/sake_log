class Post < ApplicationRecord
  belongs_to :user
  belongs_to :sake_log, optional: true
  has_many :likes, dependent: :destroy

end
