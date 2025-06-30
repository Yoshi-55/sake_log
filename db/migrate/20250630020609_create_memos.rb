class CreateMemos < ActiveRecord::Migration[7.2]
  def change
    create_table :memos do |t|
      t.string :brand
      t.integer :rating
      t.text :comment

      t.timestamps
    end
  end
end
