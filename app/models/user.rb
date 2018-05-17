class User < ApplicationRecord
  has_many :metting_users, dependent: :destroy
  has_many :mettings, through: :metting_users

  validates_presence_of :username
  validates_uniqueness_of :username

  def self.all_mettings(sql_where, sql_order, *bind_vars)
    sql = "SELECT
        cj_u.username AS username,
        cj_u.fullname AS fullname,
        GROUP_CONCAT(mu.metting_id ORDER BY mu.metting_id) AS mettings_ids,
        COUNT(mu.metting_id) AS metting_count
      FROM
        users AS cj_u
          CROSS JOIN
        mettings AS cj_mt
          LEFT JOIN
        metting_users AS mu ON cj_u.id = mu.user_id AND cj_mt.id = mu.metting_id"
    sql << sql_where
    sql << " GROUP BY username"
    sql << sql_order
    find_by_sql([sql, *bind_vars])
  end

  def merge!(other)
    super(other, attributes: self.attributes.keys, associations: %w[metting_users]) unless self.id == other.id
  end

end
