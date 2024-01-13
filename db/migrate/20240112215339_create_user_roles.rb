class CreateUserRoles < ActiveRecord::Migration[7.1]
  def up
  
    create_table :user_roles do |t|
      t.string :role_name

      t.timestamps
    end
      
  end

  def down
    
    drop_table :user_roles
  end  
  
  
end
