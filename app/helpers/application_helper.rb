module ApplicationHelper
  def site_title
    current_conference.try(:name) || ENV['SITE_TITLE'] || "Partay"
  end
end
