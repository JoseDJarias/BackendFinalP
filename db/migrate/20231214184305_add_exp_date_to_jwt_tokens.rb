class AddExpDateToJwtTokens < ActiveRecord::Migration[7.1]
  def change
    reversible do |direction|
        direction.up   { add_column :jwt_tokens, :exp_date, :integer }
        direction.down { remove_column :jwt_tokens, :exp_date, :integer }
    end  
  end
end
