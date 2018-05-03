class MettingExport
  require 'csv'
  include MettingsHelper

  attr_reader :user, :mettings, :count

  def initialize(user)
    @user = user
    @mettings = User.all_mettings(@user.id).map{|m| [m.metting_name, gtm_time(m.metting_date)] }
    @count = @mettings.select{|m| m.first.present? }.size
    @mettings = @mettings.map do |m|
      m.first.present? ? "#{m.first} | #{m.last}" : ''
    end
  end

  def do
    CSV.generate(headers: true) do |csv|
      csv << [user.username.titleize, mettings.join(','), count]
    end
  end

end