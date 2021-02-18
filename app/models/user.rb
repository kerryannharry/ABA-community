class User < ActiveRecord::Base
    has_many :group_users
    has_many :groups, through: :group_users
    validates :username, :email, presence: true, unqueness: true 
    has_secure_password
end
