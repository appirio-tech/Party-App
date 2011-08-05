class Conference < ActiveRecord::Base
  has_many :events
  validates_presence_of :name, :hashtag, :domain

  def self.from_request(request)
    find_by_domain(request.host)
  end
  def self.matches?(request) !!from_request(request) end
end
