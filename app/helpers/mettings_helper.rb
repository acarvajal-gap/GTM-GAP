module MettingsHelper

  def zebra_table(i)
    i.even? ? 'table-primary' : 'table-secondary'
  end

  def gtm_time(date, time_zone = nil, format = nil)
    return '' unless date.present?
    time_zone ||= 'Central America'
    format ||= '%a, %b %d %I:%M %p'
    date.in_time_zone(time_zone).strftime(format)
  end

end
