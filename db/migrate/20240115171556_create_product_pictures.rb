class CreateProductPictures < ActiveRecord::Migration[7.1]
  def up
    create_table :product_pictures do |t|

      t.timestamps
    end
  end
  def down
    drop_table :product_pictures
  end
end
