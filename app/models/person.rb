class Person < ApplicationRecord
    belongs_to :user

    validates :user, uniqueness: true

    validates :user_name, :user_id, presence: true
    validates :user_name, uniqueness: true
    validates :birthdate, format: { with: /\A\d{4}-\d{2}-\d{2}\z/, message: "must be in the format YYYY-MM-DD" }, allow_nil: true
    validates :name, :lastname, length: { maximum: 20 }
    validates :city, :country, length: { maximum: 50 }
end
