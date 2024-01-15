class CreateProductPictureSerializers < ActiveRecord::Migration[7.1]
  def change
    create_table :product_picture_serializers do |t|

      t.timestamps
    end
  end
end
