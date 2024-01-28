class RemoveReferencesToUsers < ActiveRecord::Migration[7.1]
  def change
    remove_reference :users, :category

  end
end
