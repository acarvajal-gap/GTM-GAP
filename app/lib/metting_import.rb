class MettingImport
  require 'spreadsheet'

  attr_reader :name, :date, :attendees, :metting, :sheet

  EMAILS = ['education', 'gapmeetings1']

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

  def find_attendee(row)
    email = row[1].try(:split, '@').try(:first)
    user = User.find_by_email(email) if email.present? && EMAILS.exclude?(email)
    user ||= User.find_or_initialize_by(username: row[0].downcase.strip, email: email)
    user.recent = true
    user
  end

  def load_attendees
    attendees = []
    @sheet.rows.drop(7).each do |row| # attendees list start on row 7
      attendees << find_attendee(row)
    end
    attendees.uniq {|a| a.username}
  end

  def save
    if sheet.present?
      metting.name = name
      metting.date = date
      metting.users << attendees
      saved = metting.save
      if saved
        User.update_all(recent: false)
        User.where(id: metting.user_ids).update_all(recent: true)
      end
      saved
    else
      false
    end
  end

end