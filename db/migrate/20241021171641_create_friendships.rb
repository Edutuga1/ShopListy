class CreateFriendships < ActiveRecord::Migration[6.1]
  def change
    create_table :friendships do |t|
      t.references :user, null: false, foreign_key: { to_table: :users } # Refers to the users table
      t.references :friend, null: false, foreign_key: { to_table: :users } # Refers to the users table
      t.string :status, default: 'pending' # Default status is 'pending'

      t.timestamps
    end
  end
end
