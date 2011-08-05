require 'digest/md5'

class Event < ActiveRecord::Base
  attr_protected :organizer_id, :approved, :conference_id

  belongs_to :conference
  belongs_to :organizer, class_name: 'User'

  mount_uploader :image, ImageUploader

  validates_presence_of :organizer, :name, :location_name, :start_time, :end_time

  after_create :send_approval_email

  scope :approved, where(approved: true)

  has_many :attendances
  has_many :users, through: :attendances

  def description_html
    Maruku.new(description).to_html.html_safe
  end

  def approve!
    self.approved = true
    save
  end

  def code
    Digest::MD5.hexdigest("-#{id}--#{start_time}--#{name}-bonkers")
  end

  def full_location
    [location_name, address, address2, city, state, zipcode].reject{|s| s.blank?}.join(', ')
  end

  def date
    start_time.to_date
  end

  def natural_start_time; start_time end
  def natural_start_time=(time)
    self.start_time = Chronic.parse(time)
  end
  
  def natural_end_time; end_time end
  def natural_end_time=(time)
    self.end_time = Chronic.parse(time)
  end

  protected 

  def send_approval_email
    EventsMailer.approval(self).deliver
  end
end
