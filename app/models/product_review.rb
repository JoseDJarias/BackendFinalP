class ProductReview < ApplicationRecord
    belongs_to :user
    belongs_to :product
  
    validates :user, presence: true
    validates :product, presence: true
    validates :review, presence: true
    validates :review_state, inclusion: { in: [true, false], message: "Debe ser verdadero o falso" }
end
