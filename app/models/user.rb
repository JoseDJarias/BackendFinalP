class User < ApplicationRecord

    has_one :jwt_token
end
