class Person < ApplicationRecord
    belongs_to :user

    validates :user, uniqueness: true
end