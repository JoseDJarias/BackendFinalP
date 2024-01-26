class Person < ApplicationRecord
    belongs_to :user

    validates :user, uniqueness: true

    validates :phone_number, presence: true
    validate :validate_phone_number_format

    
    validates :user_name, :user_id, presence: true
    validates :user_name, uniqueness: true
    validates :birthdate, format: { with: /\A\d{4}-\d{2}-\d{2}\z/, message: "must be in the format YYYY-MM-DD" }, allow_nil: true
    validates :name, :lastname, length: { maximum: 20 }
    validates :city, :country, length: { maximum: 50 }

    private 

    def validate_phone_number_format
        binding.break
      return if phone_number.blank? 
      unless phone_number.match?(/(\+506[\-\s]+?)?\d{8}/)
        errors.add(:phone_number, 'is not a valid phone number')
      end
    end
end
