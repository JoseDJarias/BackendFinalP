class AddColumnToPeople < ActiveRecord::Migration[7.1]
  def up
    add_column :people, :phone_number, :string;
  end
  def down
    remove_column :people, :phone_number
  end

end
