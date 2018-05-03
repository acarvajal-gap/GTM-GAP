class User < ApplicationRecord
  has_many :metting_users, dependent: :destroy
  has_many :mettings, through: :metting_users

  validates_presence_of :username
  validates_uniqueness_of :username

  def self.all_mettings(user_id)
    sql = "SELECT
      CASE
        WHEN metting_users.metting_id IS NOT NULL THEN mettings.name
      ELSE
        ''
      END AS metting_name,
      CASE
        WHEN metting_users.metting_id IS NOT NULL THEN mettings.date
      ELSE
        ''
      END AS metting_date
      FROM
        mettings
      LEFT JOIN
        metting_users ON mettings.id = metting_users.metting_id
      WHERE
        metting_users.metting_id IS NULL OR metting_users.user_id = ?
      ORDER BY mettings.id"
    find_by_sql([sql, user_id])
  end

end
