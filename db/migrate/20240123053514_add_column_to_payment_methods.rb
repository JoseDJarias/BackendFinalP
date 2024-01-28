class AddColumnToPaymentMethods < ActiveRecord::Migration[7.1]
  def up
    add_column :payment_methods, :available ,:boolean, default: true
  end
  
  def down
    drop_column :payment_methods, :available
  end
end
