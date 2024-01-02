class JwtToken < ApplicationRecord

    belongs_to :user

    validates_presence_of :token
    validates_presence_of :exp_date

    validates_uniqueness_of :token, case_sensitive: true
    validates_uniqueness_of :id

    validates :exp_date, comparison: { greater_than: Time.now.to_i }




end
