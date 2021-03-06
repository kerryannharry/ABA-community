class User < ActiveRecord::Base
    has_many :group_users
    has_many :groups, through: :group_users
    has_many :posts
    validates :username, presence: true, uniqueness: true, length: {in: 5..20} 
    has_secure_password
    validates :password, length: {in: 8..50}, confirmation: true, on: :create
    validates :email, presence: true, uniqueness: true, format: {with: /(?<username>[^@\s]+)@((?<domain_name>[-a-z0-9]+)\.(?<domain>[a-z]{2,}))/i}
end
