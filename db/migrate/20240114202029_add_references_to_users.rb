class AddReferencesToUsers < ActiveRecord::Migration[7.1]
  def change
    add_reference :users, :category, foreign_key: true  
  end
end
