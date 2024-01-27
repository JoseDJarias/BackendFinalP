class AddColumnToProductPictures < ActiveRecord::Migration[7.1]
  def up
    add_column :product_pictures, :description, :string
  end
  def down
    remove_column :product_pictures, :description
  end
end
