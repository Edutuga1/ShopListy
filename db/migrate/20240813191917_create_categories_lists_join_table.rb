class CreateCategoriesListsJoinTable < ActiveRecord::Migration[7.0]
  def change
    create_join_table :categories, :lists do |t|
      t.index :category_id
      t.index :list_id
    end
  end
end
