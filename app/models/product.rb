class Product < ApplicationRecord


    validates_presence_of :id,:name, :description, :unitary_price, :purchase_price, :stock, :available

    validates :unitary_price, :purchase_price, :stock, presence: true, numericality: { greater_than_or_equal_to: 0 }
end
