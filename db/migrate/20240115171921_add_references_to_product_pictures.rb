class AddReferencesToProductPictures < ActiveRecord::Migration[7.1]
  def up
    add_reference :product_pictures, :product, foreign_key:true

  end

  def down
    remove_reference :product_pictures, :product

  end

end
