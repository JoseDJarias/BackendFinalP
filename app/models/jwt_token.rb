class JwtToken < ApplicationRecord

    belongs_to :user

    validates_presence_of :token
    validates_presence_of :exp_date
    
    validates :token, uniqueness: true
    validates :id, uniqueness: true

    validates :exp_date, comparison: { greater_than: Time.now.to_i }




end
