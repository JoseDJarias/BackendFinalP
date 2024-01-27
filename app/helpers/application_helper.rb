module ApplicationHelper

    def to_boolean(item)
        ActiveRecord::Type::Boolean.new.cast(item)
    end

    
end
