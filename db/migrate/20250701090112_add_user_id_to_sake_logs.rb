class AddUserIdToSakeLogs < ActiveRecord::Migration[8.0]
  def change
    add_reference :sake_logs, :user, null: false, foreign_key: true
  end
end
