class Reports::MasterAbstract
  require 'csv'
  include MettingsHelper

  attr_reader :opts, :all_mettings, :metting, :mettings, :attendees

  def initialize(opts)
    raise NotImplementedError, "#{self.class} must define initialize"
  end

  def report_where
    raise NotImplementedError, "#{self.class} must define report_where"
  end

  def find_mettings(filter)
    if filter.present? && filter.any?
      mts = Metting.where(id: opts[:filter]).order('id ASC')
      mts = [Metting.last] if mts.empty?
    else
      mts = [Metting.last]
    end
    mts
  end

  def report_order_by(order)
    case order.to_i
    when 1
      " ORDER BY username ASC"
    when 2
      " ORDER BY username DESC"
    when 3
      " ORDER BY fullname ASC"
    when 4
      " ORDER BY fullname DESC"
    when 5
      " ORDER BY metting_count DESC"
    when 6
      " ORDER BY metting_count ASC"
    else
      " ORDER BY username ASC"
    end
  end

  def load_attendees
    values = []
    metting.each do |mtg|
      values <<
        {
          username: mtg.username,
          fullname: mtg.fullname,
          metting_list: mettings_list(mtg.mettings_ids),
          metting_count: mtg.metting_count
        }
    end
    values
  end

  def mettings_list(ids)
    if ids.present?
      ids = ids.split(',')
      mettings_list = []
      mettings.each do |mtg|
        if ids.include?(mtg.id.to_s)
          mettings_list << 1
          ids.delete(mtg.id.to_s)
        else
          mettings_list << 0
        end
      end
    else
      mettings_list = [].fill(0, 0...mettings.count)
    end

    mettings_list.join(',')
  end

  def to_csv
    CSV.generate(headers: true) do |csv|
      csv << ['Username', 'Fullname', mettings.map{|m| "#{m.name} #{m.date.strftime('%Y-%m-%d')}"}, 'Mettings Attended'].flatten

      attendees.each do |row|
        csv << [row[:username], row[:fullname], row[:metting_list].split(','), row[:metting_count]].flatten
      end
    end
  end

end