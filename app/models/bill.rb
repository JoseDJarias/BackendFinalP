class Bill < ApplicationRecord

    belongs_to :user
    belongs_to :payment_method

    has_one_attached :voucher

    has_many :product_bills
    has_many :products, through: :product_bills


    def image_url
        Rails.application.routes.url_helpers.rails_blob_path(voucher, only_path: true) if voucher.attached?
    end
end
