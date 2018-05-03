class Metting < ApplicationRecord
  has_many :metting_users, dependent: :destroy
  has_many :users, through: :metting_users

  has_attached_file :gtm_file

  validates_presence_of :name, :date, :gtm_file
  validates_attachment_content_type :gtm_file, content_type: [
    'application/vnd.ms-excel',
    'application/xls',
    'application/x-ole-storage'
  ]

end
