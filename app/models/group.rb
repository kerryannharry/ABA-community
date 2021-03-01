class Group < ActiveRecord::Base
    has_many :group_users
    has_many :users, through: :group_users
    has_many :posts
    validates :title, presence: true, uniqueness: true, inclusion: {in: ["BCBA", "BCABA", "RBT"]}

    def join_group(current_user)
        current_user.groups.include?(self) ? "Leave" : "Join"
    end
end
