class RemovePasswordFromUsers < ActiveRecord::Migration[7.1]
  def change
    reversible do |direction|
      direction.up {  remove_column :users, :password, :string}
      direction.down {  add_column :users, :password, :string}
    end  
    
  end
end
