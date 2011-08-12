module AttendancesHelper
  def rsvp_status(event)
    "I'm attending #{event.name} at #{event.location_name}. #{event_url(event)} #{current_conference.hashtag}"
  end
end
