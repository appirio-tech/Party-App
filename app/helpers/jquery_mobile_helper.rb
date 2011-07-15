module JqueryMobileHelper
  def page(options = {}, &block)
    content_tag :section, {"data-role" => "page"}.merge(options), &block
  end

  def header(options = {}, &block)
    content_tag :header, {"data-theme" => "b", "data-role" => "header"}.merge(options), &block
  end

  def content(options = {}, &block)
    content_tag :div, {"data-role" => "content"}.merge(options), &block
  end
end
