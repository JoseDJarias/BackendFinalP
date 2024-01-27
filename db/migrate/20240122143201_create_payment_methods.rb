class CreatePaymentMethods < ActiveRecord::Migration[7.1]
  def up
    create_table :payment_methods do |t|
      t.string :method, null: false
      t.timestamps
    end
  end

  def down
    drop_table :payment_methods
  end
end
