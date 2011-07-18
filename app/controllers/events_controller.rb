class EventsController < ApplicationController
  before_filter :login_required, only: [:new, :create]
  before_filter :set_event, only: [:show, :edit, :update, :approve]

  def index
    @events = Event.approved.order("start_time ASC, end_time ASC, name ASC")
  end

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

  def edit
  end

  def update
    if @event.update_attributes(params[:event])
      redirect_to event_path(@event), notice: 'Updated event successfully.'
    else
      flash.now[:alert] = "Problem updating event."
      render action: 'edit'
    end
  end

  def show
    unless @event.approved? || @event.organizer == current_user
      raise ActiveRecord::RecordNotFound
    end
  end

  def approve
    unless @event.code == params[:code] && @event.approve!  
      raise ActiveRecord::RecordNotFound
    end
  end

  protected

  def set_event
    @event = Event.includes(:users).find_by_id!(params[:id])
  end
end
