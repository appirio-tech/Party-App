class EventsController < ApplicationController
  before_filter :login_required, only: [:new, :create]
  before_filter :set_event, only: [:show, :edit, :update]

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(params[:event])
    @event.organizer = current_user

    if @event.save
      redirect_to event_path(@event), notice: "Event created successfully!"
    else
      flash.new[:alert] = "There were problems creating your event."
      render action: :new
    end
  end

  def show
    unless @event.approved? || @event.organizer == current_user
      raise ActiveRecord::RecordNotFound
    end
  end

  protected

  def set_event
    @event = Event.find_by_id!(params[:id])
  end
end
