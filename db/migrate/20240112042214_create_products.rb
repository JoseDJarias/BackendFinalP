class CreateProducts < ActiveRecord::Migration[7.1]
  def change
   
    reversible do |dir|
      dir.up do
        create_table :products do |t|
          t.string :name
          t.string :description
          t.integer :unitary_price
          t.integer :purchase_price
          t.integer :stock
          t.boolean :available
  
          t.timestamps
        end
       
      end 
     
      dir.down do
        drop_table :products
      end
     
    end 
  end
end
