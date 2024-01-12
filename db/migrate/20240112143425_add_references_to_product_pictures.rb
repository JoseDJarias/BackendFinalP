class AddReferencesToProductPictures < ActiveRecord::Migration[7.1]
  def change
    add_reference :product_pictures, :product, foreign_key: true
  end
end
