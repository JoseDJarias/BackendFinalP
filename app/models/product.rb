class Product < ApplicationRecord

    has_many :product_pictures

    belongs_to :category

    has_many :product_review

    has_many :product_bills
    has_many :bills, through: :product_bills 

    validates_presence_of :name, :description, :unitary_price, :purchase_price, :stock, :available, :category_id

    validates :unitary_price, :purchase_price, :stock, presence: true, numericality: { greater_than_or_equal_to: 0 }
    
    validates :stock, numericality: { greater_than_or_equal_to: 0 }
end
