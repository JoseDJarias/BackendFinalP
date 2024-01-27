class AddUserReftToJwtTokens < ActiveRecord::Migration[7.1]
  def up
    add_reference :jwt_tokens, :user, null: false, foreign_key: true
  
  end  
  def down
    remove_reference :jwt_tokens, :user
  end
end
