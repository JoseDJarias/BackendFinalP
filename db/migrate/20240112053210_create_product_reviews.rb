class CreateProductReviews < ActiveRecord::Migration[7.1]
  def change
    reversible do |dir|
 
 
      dir.up do
        create_table :product_reviews, id: false do |t|
          t.references :user, foreign_key: true
          t.references :product, foreign_key: true
          t.text :review
          t.boolean :review_state
         
          t.timestamps
        end
      end 
     
      dir.down do
        drop_table :products_pictures
      end
     
    end 
  end
 
end
