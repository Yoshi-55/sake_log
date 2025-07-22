class SakeLog < ApplicationRecord
  belongs_to :user
  has_many :posts, dependent: :nullify

  validates :name, presence: true, length: { maximum: 30 }
  validates :taste, length: { maximum: 20 }
  validates :memo, length: { maximum: 40 }
  
  validates :sweetness, :sourness, :spiciness, :bitterness, :umami,
            presence: true,
            inclusion: { in: 1..5, message: "1から5の範囲で入力してください" }

  scope :recent, -> { order(created_at: :desc) }

  def radar_data
    {
      sweetness: sweetness,
      sourness: sourness,
      spiciness: spiciness,
      bitterness: bitterness,
      umami: umami
    }
  end

  def radar_labels
    ['甘味', '酸味', '辛味', '苦味', '旨味']
  end

  def radar_values
    [sweetness, sourness, spiciness, bitterness, umami]
  end
end
