class User < ActiveRecord::Base
  has_many :owned_events, class_name: 'Event', foreign_key: 'owner_id'
  has_many :event_users
  has_many :events, through: :event_users
end
