class UserRole < ApplicationRecord
    belongs_to :user

    before_validation :validate_user_presence

    def validate_user_presence
      unless User.exists?(id: user_id)
        errors.add(:user, "must exist")
      end
    end
end
