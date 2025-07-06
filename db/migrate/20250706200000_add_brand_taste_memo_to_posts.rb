class AddBrandTasteMemoToPosts < ActiveRecord::Migration[7.0]
  def change
    add_column :posts, :brand, :string, limit: 30
    add_column :posts, :taste, :string, limit: 20
    add_column :posts, :memo, :text, limit: 80
  end
end
