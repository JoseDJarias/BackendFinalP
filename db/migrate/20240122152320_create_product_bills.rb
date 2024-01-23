class CreateProductBills < ActiveRecord::Migration[7.1]
  def change
    create_table :product_bills do |t|
      t.references :product, null: false, foreign_key: true
      t.references :bill, null: false, foreign_key: true
      t.integer :quantity
      t.integer :cost
      t.integer :total

      t.timestamps
    end
  end
end
