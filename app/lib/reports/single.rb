class Reports::Single < Reports::MasterAbstract

  def initialize(opts)
    @opts = opts
    @mettings = Metting.all.order('id ASC')
    @metting = User.all_mettings(
        report_where,
        report_order_by(opts[:order]),
        mettings_ids: mettings.map(&:id), user_id: opts[:user_id]
    )
    @attendees = load_attendees
  end

  def report_where
    " WHERE cj_mt.id IN (:mettings_ids) AND cj_u.id = :user_id"
  end

end