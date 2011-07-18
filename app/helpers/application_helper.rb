module ApplicationHelper
  def site_title
    ENV['SITE_TITLE'] || "Partay"
  end
end
