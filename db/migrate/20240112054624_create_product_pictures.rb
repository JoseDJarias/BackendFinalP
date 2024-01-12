class CreateProductPictures < ActiveRecord::Migration[7.1]
  def change
    reversible do |dir|
 
      dir.up do
        create_table :product_pictures do |t|
          t.string :source
         
          t.timestamps
        end
      end 
     
      dir.down do
        drop_table :products_pictures
      end
     
    end 
  end
end
 
 
 
