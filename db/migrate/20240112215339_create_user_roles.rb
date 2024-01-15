class CreateUserRoles < ActiveRecord::Migration[7.1]
  def up
  
    create_table :user_roles do |t|
      t.references :user, null: false, primary_key: true, foreign_key: true
      t.remove_column :id
      t.string :role_name, default: "user", null: false

      t.timestamps
    end
      
  end

  def down
    
    drop_table :user_roles
  end  
  
  
end
