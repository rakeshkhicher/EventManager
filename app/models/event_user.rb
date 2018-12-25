class EventUser < ActiveRecord::Base
  belongs_to :user
  belongs_to :event
  enum status: { pending: 0, accepted: 1 }
  validates_uniqueness_of :user_id, scope: [:event_id]

  after_create :send_activation_link

  def send_activation_link
    UserMailer.event_invitation_link_email(self).deliver_later
  end
end
