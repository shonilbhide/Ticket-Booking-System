class Admin < ApplicationRecord
    include SingleInstanceModel
    has_secure_password
    
end
