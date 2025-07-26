
class Post < ApplicationRecord
  belongs_to :user
  belongs_to :sake_log, optional: true
  has_many :likes, dependent: :destroy

  validates :brand, presence: true, length: { maximum: 30 }
  validates :memo, length: { maximum: 40 }

  scope :search, ->(query) do
    return all if query.blank?

    sanitized_query = "%#{query}%"
    where("brand LIKE ? OR memo LIKE ?",
          sanitized_query, sanitized_query)
  end

  scope :recent, -> { order(created_at: :desc) }

  # 味覚情報を取得するヘルパーメソッド
  def taste_description
    return "味覚情報なし" unless sake_log

    taste_elements = []
    taste_elements << "甘味#{sake_log.sweetness}" if sake_log.sweetness > 3
    taste_elements << "酸味#{sake_log.sourness}" if sake_log.sourness > 3
    taste_elements << "苦味#{sake_log.bitterness}" if sake_log.bitterness > 3
    taste_elements << "旨味#{sake_log.umami}" if sake_log.umami > 3
    taste_elements << "辛味#{sake_log.spiciness}" if sake_log.spiciness > 3

    taste_elements.any? ? taste_elements.join(", ") : "バランス良好"
  end

  # レーダーチャート用のデータを取得
  def radar_data
    return nil unless sake_log
    sake_log.radar_data
  end

  # レーダーチャート用のラベルを取得
  def radar_labels
    return [] unless sake_log
    sake_log.radar_labels
  end

  # レーダーチャート用の値を取得
  def radar_values
    return [] unless sake_log
    sake_log.radar_values
  end

  # レーダーチャートが表示可能かチェック
  def has_radar_data?
    sake_log.present?
  end
end
