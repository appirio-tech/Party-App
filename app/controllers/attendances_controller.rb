class AttendancesController < ApplicationController
  before_filter :login_required, :set_event

  def create
    if @attendance = Attendance.create!(user: current_user, event: @event)
      flash[:notice] = "Successfully RSVP'ed"
    else
      flash[:alert] = "Couldn't RSVP"
    end

    redirect_to event_path(@event)
  end

  def destroy
    @attendance = @event.attendances.find_by_user_id!(current_user.id)
    @attendance.destroy
    redirect_to event_path(@event)
  end

  protected

  def set_event
    @event = Event.find(params[:id])
  end
end
