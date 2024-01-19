class AddExpDateToJwtTokens < ActiveRecord::Migration[7.1]
  def up
    add_column :jwt_tokens, :exp_date, :integer 
  end
  def down
    remove_column :jwt_tokens, :exp_date
  end
end
