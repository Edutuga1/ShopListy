class AddDeletedFlagsToMessages < ActiveRecord::Migration[7.1]
  def change
    add_column :messages, :sender_deleted, :boolean, default: false
    add_column :messages, :receiver_deleted, :boolean, default: false
  end
end
