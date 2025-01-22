class CreateNotifications < ActiveRecord::Migration[7.1]
  def change
    create_table :notifications do |t|
      t.references :user, null: false, foreign_key: true
      t.references :friend, null: false, foreign_key: { to_table: :users }
      t.references :list, null: false, foreign_key: true
      t.string :message
      t.boolean :read

      t.timestamps
    end
  end
end
