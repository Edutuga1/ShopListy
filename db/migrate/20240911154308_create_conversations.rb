class CreateConversations < ActiveRecord::Migration[7.1]
  def change
    create_table :conversations do |t|
      t.integer :sender_id, null: false
      t.integer :receiver_id, null: false

      t.timestamps
    end

    # Adding a foreign key reference to messages for conversation
    add_reference :messages, :conversation, foreign_key: true
  end
end
