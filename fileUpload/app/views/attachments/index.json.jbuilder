json.array!(@attachments) do |attachment|
  json.extract! attachment, :id, :file_contents, :file_name, :content_type, :file_size, :forum_id
  json.url attachment_url(attachment, format: :json)
end
