class CreateTodos < ActiveRecord::Migration[7.1]
  def change
    reversible do |dir|

        dir.up do
          create_table :todos do |t|
            t.string :title
    
            t.timestamps
          end
        end   

        dir.down do
          drop_table :todo
        end  
     
    end     
  end
end
