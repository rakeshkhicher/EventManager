class EventUsersController < ApplicationController
  before_action :find_event

  def accept_invite
    event_user = @event.event_users.find(params[:id])
    user = event_user.user
    event_user.accepted! if avability_of_slot(event_user.event, user)
    redirect_to root_url(@event)
  end

  private

  def find_event
    @event = Event.find(params[:event_id])
  end

  def avability_of_slot(event, user)
    return true if user.event_users.accepted.nil?
    
    start_date = event.start_date.to_date
    end_date = event.end_date.to_date
    user.events.joins(:event_users).where(event_users: { status: 1 })
        .where('date(start_date) <= ? and Date(end_date) >= ?', start_date, end_date).blank?
  end
end
