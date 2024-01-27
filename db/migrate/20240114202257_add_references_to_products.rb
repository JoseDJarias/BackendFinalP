class AddReferencesToProducts < ActiveRecord::Migration[7.1]
  def up
    add_reference :products, :category, foreign_key: true
  end
  def down
    remove_reference :products, :category
  end
end
