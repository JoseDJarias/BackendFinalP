class CreatePeople < ActiveRecord::Migration[7.1]
  def change

    reversible do |dir|

      dir.up do 
          create_table :people do |t|
            t.references :user, null: false, primary_key: true, foreign_key: true
            t.remove_column :id
            t.string :user_name
            t.string :name
            t.string :lastname
            t.date :birthdate
            t.string :city
            t.string :country
            
          end
      end

      dir.down do 
        drop_table :people
      end

    end

  end
end
