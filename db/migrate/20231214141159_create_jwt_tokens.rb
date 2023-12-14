class CreateJwtTokens < ActiveRecord::Migration[7.1]
  def change

      reversible do |dir|

          dir.up do
            create_table :jwt_tokens do |t|
              t.string :token
        
              t.timestamps
            end
            add_index :jwt_tokens, :token
          end  
          
          dir.down do
          drop_table :jwt_tokens
          end
          
      end  
  
  end
end
