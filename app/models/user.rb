class User < ApplicationRecord

    has_one :jwt_token

    validates_presence_of :email
    validates_presence_of :password

    validates :email, format: {with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/,
    message: 'is not in a valid format' }
    validates :password, length: { minimum: 4, maximum: 20 }

    validates :email, uniqueness: true


end
