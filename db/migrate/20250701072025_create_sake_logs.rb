class CreateSakeLogs < ActiveRecord::Migration[8.0]
  def change
    create_table :sake_logs do |t|
      t.string :name
      t.string :taste
      t.text :memo

      t.timestamps
    end
  end
end
