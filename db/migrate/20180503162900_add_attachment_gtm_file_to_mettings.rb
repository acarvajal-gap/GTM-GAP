class AddAttachmentGtmFileToMettings < ActiveRecord::Migration[5.2]
  def self.up
    change_table :mettings do |t|
      t.attachment :gtm_file
    end
  end

  def self.down
    remove_attachment :mettings, :gtm_file
  end
end
