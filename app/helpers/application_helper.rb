module ApplicationHelper
  BLANK_LINK = ''.freeze

  def title(page_title)
    content_for(:title) { page_title }
    page_title
  end

  def humanize_date_in_time_zone(datetime)
    I18n.l(datetime.in_time_zone(current_user.time_zone), format: '%a, %d %b %Y %H:%M:%S'.freeze)
  end
end
