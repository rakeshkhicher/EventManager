class UserMailer < ApplicationMailer
  default from: 'notifications@example.com'
 
  def event_invitation_link_email(event_user)
    @user = event_user.user
    @event = event_user.event
    @url = "http://localhost:3000/events/#{@event.id}/event_users/#{event_user.id}/accept_invite"
    mail(to: @user.email, subject: 'Event Invitation')
  end

  def send_event_update_mail(event_user, event)
    @user = event_user.user
    @event = event
    mail(to: @user.email, subject: 'Event Updation')
  end
end
