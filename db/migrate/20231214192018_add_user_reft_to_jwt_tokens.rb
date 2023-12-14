class AddUserReftToJwtTokens < ActiveRecord::Migration[7.1]
  def change
    reversible do |direction|
      direction.up   {   add_reference :jwt_tokens, :user, null: false, foreign_key: true}
      direction.down {   remove_reference :jwt_tokens, :user, null: false, foreign_key: true }
    end  
  end
end
