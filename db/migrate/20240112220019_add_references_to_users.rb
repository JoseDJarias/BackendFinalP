class AddReferencesToUsers < ActiveRecord::Migration[7.1]
  def up
    add_reference :users, :user_role, foreign_key: true
 
  end
  def down
    remove_reference :users, :user_role
  end
end
