class EventsController < ApplicationController
  before_filter :login_required, only: [:new, :create]
  before_filter :set_event, only: [:show, :edit, :update, :approve, :calendar]

  def index
    @events = current_conference.events.approved.order("start_time ASC, end_time ASC, name ASC")
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(params[:event])
    @event.conference = current_conference
    @event.organizer = current_user

    if @event.save
      redirect_to event_path(@event), notice: "Event created successfully!"
    else
      flash.new[:alert] = "There were problems creating your event."
      render action: :new
    end
  end

  def edit
    redirect_to event_path(@event), alert: "Only the organizer can edit events." unless @event.organizer == current_user
  end

  def update
    if @event.update_attributes!(params[:event])
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

  def calendar
    cal = Icalendar::Calendar.new
    
    event = Icalendar::Event.new

    event.summary = @event.name
    event.uid = [request.host, @event.id].join('@')    
    event.start = @event.start_time.to_datetime
    event.end = @event.end_time.to_datetime
    event.location = @event.full_location
    event.url = event_url(@event)
    event.description = @event.description if @event.description?

    cal.add_event(event)

    render text: cal.to_ical, content_type: 'text/calendar; charset=UTF-8'
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
