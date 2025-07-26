class FixSakeLogColumns < ActiveRecord::Migration[8.0]
  def change
    # 存在する場合のみ削除（安全に実行）
    remove_column :sake_logs, :dryness, :integer if column_exists?(:sake_logs, :dryness)
    remove_column :sake_logs, :lightness, :integer if column_exists?(:sake_logs, :lightness)
    remove_column :sake_logs, :richness, :integer if column_exists?(:sake_logs, :richness)
    remove_column :sake_logs, :clarity, :integer if column_exists?(:sake_logs, :clarity)

    # 存在しない場合のみ追加（安全に実行）
    add_column :sake_logs, :spiciness, :integer, default: 3, null: false, comment: '辛味 (1-5)' unless column_exists?(:sake_logs, :spiciness)
  end
end
