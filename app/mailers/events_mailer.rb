class EventsMailer < ActionMailer::Base
  default from: "no-reply@socialspring.com"

  def approval(event)
    @event = event
    @user = event.organizer

    mail(
      to: ENV["ADMIN_EMAIL"] || "michael@intridea.com",
      subject: "Event Approval Notice - #{@event.name}"
    )
  end
end
