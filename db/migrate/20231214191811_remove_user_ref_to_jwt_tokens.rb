class RemoveUserRefToJwtTokens < ActiveRecord::Migration[7.1]
  def change
    remove_reference :jwt_tokens, :user, null: false, foreign_key: true

  end
end
