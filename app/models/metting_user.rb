class MettingUser < ApplicationRecord
  belongs_to :metting
  belongs_to :user
end
