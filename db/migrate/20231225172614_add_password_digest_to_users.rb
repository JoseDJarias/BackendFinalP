class AddPasswordDigestToUsers < ActiveRecord::Migration[7.1]
  def change
    reversible do |direction|
      direction.up {  add_column :users, :password_digest, :string}
      direction.down {  remove_column :users, :password_digest, :string}
    end  
  end
end
