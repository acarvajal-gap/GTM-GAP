class Reports::Master
  require 'csv'
  include MettingsHelper

  attr_reader :metting, :mettings, :attendees

  def initialize(user_id=nil)
    @metting = User.all_mettings(user_id)
    @mettings = Metting.all.order('id ASC')
    @attendees = load_attendees
  end

  def load_attendees
    values = []
    metting.each do |mtg|
      values <<
        {
          username: mtg.username.titleize,
          metting_list: mettings_list(mtg.mettings_ids.split(',')),
          metting_count: mtg.metting_count
        }
    end
    values
  end

  def mettings_list(ids)
    mettings_list = []
    mettings.each do |mtg|
      if ids.include?(mtg.id.to_s)
        mettings_list << ["#{mtg.name} #{gtm_time(mtg.date, nil, '%a %b %d %I:%M %p')}"]
        ids.delete(mtg.id.to_s)
      else
        mettings_list << ''
      end
    end
    mettings_list.join(',')
  end

  def to_csv
    CSV.generate(headers: true) do |csv|
      attendees.each do |row|
        csv << [row[:username], row[:metting_list], row[:metting_count]]
      end
    end
  end

end