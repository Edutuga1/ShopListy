class CreateJoinTableListsItems < ActiveRecord::Migration[7.1]
  def change
    create_join_table :lists, :items do |t|
      # t.index [:list_id, :item_id]
      # t.index [:item_id, :list_id]
    end
  end
end
