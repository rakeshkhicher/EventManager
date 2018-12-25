class Event < ActiveRecord::Base
  belongs_to :owner, class_name: 'User'
  has_many :event_users, dependent: :destroy
  has_many :users, through: :event_users
  validates_presence_of :title, :description, :start_date, :end_date
  after_update :sent_email_to_users

  def start_time
    start_date
  end

  def sent_email_to_users
    return true unless self.changed?
    event_users.each do |event_user|
      UserMailer.send_event_update_mail(event_user, self).deliver_later
    end
  end
end
