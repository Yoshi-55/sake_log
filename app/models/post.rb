class Post < ApplicationRecord
  belongs_to :user
  belongs_to :sake_log, optional: true

end
