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
          metting_list: mtg.mettings_ids,
          metting_count: mtg.metting_count
        }
    end
    values
  end

  def to_csv
    CSV.generate(headers: true) do |csv|
      csv << ['Username', @mettings.map{|m|m.name}, 'Mettings Attended'].flatten

      attendees.each do |row|
        csv << [row[:username], row[:metting_list].split(','), row[:metting_count]].flatten
      end
    end
  end

end