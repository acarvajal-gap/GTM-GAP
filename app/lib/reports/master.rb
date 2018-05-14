class Reports::Master
  require 'csv'
  include MettingsHelper

  attr_reader :metting, :mettings, :attendees

  def initialize(user_id=nil)
    @mettings = Metting.all.order('id ASC')
    @metting = User.all_mettings(user_id)
    @attendees = load_attendees
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
      csv << ['Username', 'Fullname', @mettings.map{|m| "#{m.name} #{m.date.strftime('%Y-%m-%d')}"}, 'Mettings Attended'].flatten

      attendees.each do |row|
        csv << [row[:username], row[:fullname], row[:metting_list].split(','), row[:metting_count]].flatten
      end
    end
  end

end