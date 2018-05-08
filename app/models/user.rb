class User < ApplicationRecord
  has_many :metting_users, dependent: :destroy
  has_many :mettings, through: :metting_users

  validates_presence_of :username
  validates_uniqueness_of :username

  def self.all_mettings(user_id=nil)
    sql = "SELECT
        users.username AS username,
        GROUP_CONCAT(concat(mettings.id), '') AS mettings_ids,
        count(*) AS metting_count
      FROM
        mettings
      LEFT JOIN
        metting_users ON mettings.id = metting_users.metting_id
      LEFT JOIN
        users ON metting_users.user_id = users.id"
    sql << " WHERE users.id = ?" if user_id.present?
    sql << " GROUP BY username"
    sql << " ORDER BY mettings.id"
    find_by_sql([sql, user_id])
  end

end
