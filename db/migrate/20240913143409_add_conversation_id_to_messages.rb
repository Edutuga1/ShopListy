class AddConversationIdToMessages < ActiveRecord::Migration[7.1]
  def change
    # Check if the conversation_id column already exists
    unless column_exists?(:messages, :conversation_id)
      add_column :messages, :conversation_id, :integer
    end
  end
end
