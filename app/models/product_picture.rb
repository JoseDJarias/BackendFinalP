class ProductPicture < ApplicationRecord
    # i am not creating yet a bidirectional relations, just a pic belongs to a product
    belongs_to :product
    
end
