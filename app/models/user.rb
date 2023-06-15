class User < ApplicationRecord
    mount_uploader :avatar, AvatarUploader

    has_secure_password
    scope :all_except, ->(user) { where.not(id: Current.user)}
    validates :email, presence: true, uniqueness: true, length: { maximum: 20 }  
    after_create_commit { broadcast_append_to 'users' }
    has_many :messages
end