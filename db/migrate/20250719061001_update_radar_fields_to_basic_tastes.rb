class UpdateRadarFieldsToBasicTastes < ActiveRecord::Migration[8.0]
  def change
    # 既存のフィールドを削除
    remove_column :sake_logs, :dryness, :integer
    remove_column :sake_logs, :lightness, :integer
    remove_column :sake_logs, :richness, :integer
    remove_column :sake_logs, :clarity, :integer

    # 基本5味のフィールドを追加
    add_column :sake_logs, :sourness, :integer, default: 3, null: false, comment: '酸味 (1-5)'
    add_column :sake_logs, :spiciness, :integer, default: 3, null: false, comment: '辛味 (1-5)'
    add_column :sake_logs, :bitterness, :integer, default: 3, null: false, comment: '苦味 (1-5)'
    add_column :sake_logs, :umami, :integer, default: 3, null: false, comment: '旨味 (1-5)'

    # sweetnessはそのまま使用（甘味）
  end
end
