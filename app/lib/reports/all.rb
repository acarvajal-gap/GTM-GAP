class Reports::All < Reports::MasterAbstract

  def initialize(opts)
    @opts = opts
    @all_mettings = Metting.all.order('id ASC')
    @mettings = find_mettings(opts[:filter])
    @metting = User.all_mettings(report_where, report_order_by(opts[:order]), mettings_ids: mettings.map(&:id))
    @attendees = load_attendees
  end

  def report_where
    " WHERE cj_mt.id IN (:mettings_ids)"
  end

end