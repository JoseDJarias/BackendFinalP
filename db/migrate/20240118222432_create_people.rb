class CreatePeople < ActiveRecord::Migration[7.1]
  def up
    create_table :people do |t|
      t.references :user, null: false, primary_key: true, foreign_key: true
      t.remove_column :id
      t.string :user_name
      t.string :name
      t.string :lastname
      t.date :birthdate
      t.string :city
      t.string :country

      t.timestamps      
    end       
  end
      

  def down 
    drop_table :people
  end

end
