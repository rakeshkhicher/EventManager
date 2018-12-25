module EventsHelper
  
  def unaccepted_events(user, date)
    return unless user
    EventUser.joins(:event).where('Date(start_date) = ?', date)
             .where(events: { owner_id: user.id }, status: 0).uniq.count
  end

  def accepted_events(user, date)
    return unless user
    EventUser.joins(:event).where('Date(start_date) = ?', date)
             .where(events: { owner_id: user.id }, status: 1).uniq.count
  end

  def events_present_on_date(user, date)
    user.owned_events.where('Date(start_date) = ?', date).present?
  end
end
