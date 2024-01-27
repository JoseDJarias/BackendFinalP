class CreateUsers < ActiveRecord::Migration[7.1]
  def change

    reversible do |dir|

      dir.up do
        create_table :users do |t|
          t.string :email
          t.string :password
          
          
          t.timestamps
        end
      end   

      dir.down do
        drop_table :users
      end  
     
    end  
  end

end
