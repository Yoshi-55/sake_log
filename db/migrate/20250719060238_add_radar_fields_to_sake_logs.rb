class AddRadarFieldsToSakeLogs < ActiveRecord::Migration[8.0]
  def change
    add_column :sake_logs, :sweetness, :integer, default: 3, null: false, comment: '甘味 (1-5)'
    add_column :sake_logs, :dryness, :integer, default: 3, null: false, comment: '辛味 (1-5)'
    add_column :sake_logs, :lightness, :integer, default: 3, null: false, comment: '軽さ (1-5)'
    add_column :sake_logs, :richness, :integer, default: 3, null: false, comment: '濃厚さ (1-5)'
    add_column :sake_logs, :clarity, :integer, default: 3, null: false, comment: '透明感 (1-5)'
  end
end
