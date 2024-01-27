class CreateBills < ActiveRecord::Migration[7.1]
  def change
    create_table :bills do |t|
      t.references :payment_method, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
