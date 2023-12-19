class ChangeColumnTokenToJwtToken < ActiveRecord::Migration[7.1]
  def change
    reversible do |direction|
      direction.up   {   change_column :jwt_tokens, :token, :string}
      direction.down {   change_column :jwt_tokens, :token, :integer }
    end  
  end
end
