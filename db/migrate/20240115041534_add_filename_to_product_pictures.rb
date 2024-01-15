class AddFilenameToProductPictures < ActiveRecord::Migration[7.1]
  def up
    add_column :product_pictures, :filename, :string
  end
  def down
    remove_column :product_pictures, :filename, :string
  end
end
