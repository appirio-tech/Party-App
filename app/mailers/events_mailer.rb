class EventsMailer < ActionMailer::Base
  default from: "dave@cloudspokes.com"

  def approval(event)
    @event = event
    @user = event.organizer

    mail(
      to: ENV["ADMIN_EMAIL"] || "dave@cloudspokes.com",
      subject: "Event Approval Notice - #{@event.name}"
    )
  end
end
