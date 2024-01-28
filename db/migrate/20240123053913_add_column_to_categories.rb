class AddColumnToCategories < ActiveRecord::Migration[7.1]
  def up
    add_column :categories, :available ,:boolean, default: true
  end
  
  def down
    drop_column :categories, :available
  end
end
