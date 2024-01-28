class PaymentMethod < ApplicationRecord

    has_one  :bill

    validates_presence_of :method
    validates_presence_of :available
end
