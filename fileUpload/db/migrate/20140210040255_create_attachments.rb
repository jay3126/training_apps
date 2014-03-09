class CreateAttachments < ActiveRecord::Migration
  def change
    create_table :attachments do |t|
      t.binary :file_contents
      t.string :file_name
      t.string :content_type
      t.string :file_size
      t.integer :forum_id

      t.timestamps
    end
  end
end
