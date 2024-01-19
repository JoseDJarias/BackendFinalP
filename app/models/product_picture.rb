class ProductPicture < ApplicationRecord
    # i am not creating yet a bidirectional relations, just a pic belongs to a product
    belongs_to :product
    
    has_one_attached :image

    validates_presence_of :product_id, :description

    def image_url
      Rails.application.routes.url_helpers.rails_blob_path(image, only_path: true) if image.attached?
    end

    
end
