class Category < ApplicationRecord
    has_many :products
    validates_presence_of :name
    validates_presence_of :available

end
