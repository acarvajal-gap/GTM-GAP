class MettingUser < ApplicationRecord
  belongs_to :metting
  belongs_to :user

  validates_uniqueness_of :user_id, scope: [:metting_id]

end
