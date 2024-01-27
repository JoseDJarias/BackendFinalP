class User < ApplicationRecord

    has_secure_password

    has_one :jwt_token

    has_one :person

    has_one :user_role

    has_many :bills

    has_one :product_review

    validates_presence_of :email
    validates_presence_of :password

    validates :email, format: {with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/,
    message: 'is not in a valid format' }
    validates :password, length: { minimum: 4, maximum: 20 }

    validates :email, uniqueness: true

    

end
