class AddCascadeDeleteToSavedLists < ActiveRecord::Migration[7.1]
  def change
    remove_foreign_key :saved_lists, :lists
    add_foreign_key :saved_lists, :lists, on_delete: :cascade
  end
end
