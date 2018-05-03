class MettingImport
  require 'spreadsheet'

  attr_reader :name, :date, :attendees, :metting, :sheet

  def initialize(params)
    @metting = Metting.new(params)
    begin
      @sheet = Spreadsheet.open(params[:gtm_file].path).worksheet(0)
      @name = load_name
      @date = load_date
      @attendees = load_attendees
    rescue Exception => e
      @metting.errors.add(:base, e.message)
    end
  end

  def load_name
    @sheet.row(0)[0].chomp(' Attendees')
  end

  def load_date
    @sheet.row(3)[0]
  end

  def load_attendees
    attendees = []
    @sheet.rows.drop(7).each do |row| # attendees list start on row 7
      attendees << User.find_or_initialize_by(username: row[0].downcase.strip)
    end
    attendees.uniq {|a| a.username}
  end

  def save
    if sheet.present?
      metting.name = name
      metting.date = date
      metting.users << attendees
      metting.save
    else
      false
    end
  end

end