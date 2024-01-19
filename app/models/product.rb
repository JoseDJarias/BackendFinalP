class Product < ApplicationRecord

    has_many :product_pictures

    belongs_to :category

    validates_presence_of :name, :description, :unitary_price, :purchase_price, :stock, :available, :category_id

    validates :unitary_price, :purchase_price, :stock, presence: true, numericality: { greater_than_or_equal_to: 0 }
end
