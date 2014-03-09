class AddFileSummaryToAttachments < ActiveRecord::Migration
  def change
    add_column :attachments, :file_summary, :text
  end
end
