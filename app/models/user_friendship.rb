class UserFriendship < ActiveRecord::Base
	belongs_to :user
	belongs_to :friend, class_name: 'User', foreign_key: 'friend_id'

	attr_accessor :user, :friend, :user_id, :friend_id
end
