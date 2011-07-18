class Event < ActiveRecord::Base
  belongs_to :organizer, class_name: 'User'

  mount_uploader :image, ImageUploader

  validates_presence_of :organizer, :name, :location_name, :start_time, :end_time

  def description_html
    Maruku.new(description).html
  end

  def natural_start_time; start_time end
  def natural_start_time=(time)
    self.start_time = Chronic.parse(time)
  end
  
  def natural_end_time; end_time end
  def natural_end_time=(time)
    self.end_time = Chronic.parse(time)
  end
end
