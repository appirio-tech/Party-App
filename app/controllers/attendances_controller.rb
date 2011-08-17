class AttendancesController < ApplicationController
  before_filter :login_required, :set_event

  def create
    if @attendance = Attendance.create!(user: current_user, event: @event)
      flash[:notice] = "Successful checkin"
    else
      flash[:alert] = "Couldn't checkin"
    end

    redirect_to attendance_event_path(@event)
  end

  def show
    redirect_to event_path(@event) unless @event.users.include?(current_user)
  end

  def destroy
    @attendance = @event.attendances.find_by_user_id!(current_user.id)
    @attendance.destroy
    redirect_to event_path(@event)
  end

  protected

  def set_event
    @event = Event.includes(:users).find(params[:id])
  end
end
