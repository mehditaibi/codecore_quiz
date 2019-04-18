class User < ApplicationRecord
    
    has_many :ideas, dependent: :nullify
    has_many :reviews, dependent: :nullify

    has_secure_password
   
    validates :email, presence: true, 
                      uniqueness: true, 
                      format: /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
end
