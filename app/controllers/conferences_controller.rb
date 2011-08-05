class ConferencesController < ApplicationController
  skip_before_filter :conference_required
  before_filter :admin_required
  before_filter :set_conference, only: [:edit, :update, :destroy, :show]

  def index
    @conferences = Conference.order(:name).all
  end

  def new
    @conference = Conference.new
  end

  def create
    if @conference = Conference.create(params[:conference])
      redirect_to conference_path(@conference), notice: "Conference created successfully."
    else
      flash.now[:alert] = "Problem creating conference."
      render action: 'new'
    end
  end

  def update
    if @conference.update_attributes(params[:conference])
      redirect_to conference_path(@conference), notice: 'Conference updated successfully.'
    else
      flash.now[:alert] = "Unable to update conference."
      render action: 'edit'
    end
  end

  def destroy
    if @conference.destroy
      redirect_to conferences_path, notice: "Conference removed successfully."
    else
      redirect_to conference_path(@conference), alert: "Unable to delete conference."
    end
  end


  protected

  def admin_required
    authenticate_or_request_with_http_basic do |username, password|
      username == ENV['ADMIN_USER'] && password == ENV['ADMIN_PASSWORD']
    end
  end

  def set_conference
    @conference = Conference.find(params[:id])
  end
end
