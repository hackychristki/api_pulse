module MonitoredApisHelper
  def status_badge(api_check)
    status, css_class = if api_check.nil?
      [ "Noch nicht geprüft", "status-unknown" ]
    elsif api_check.online?
      [ "Online", "status-online" ]
    else
      [ "Offline", "status-offline" ]
    end

    content_tag(:span, status, class: "status-badge #{css_class}")
  end

  def formatted_check_time(api_check)
    return "–" if api_check.nil?

    api_check.checked_at.in_time_zone.strftime("%d.%m.%Y, %H:%M:%S")
  end

  def formatted_response_time(value)
    value.nil? ? "–" : "#{value} ms"
  end
end
