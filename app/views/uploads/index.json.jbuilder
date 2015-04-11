json.array!(@uploads) do |upload|
  json.extract! upload, :id, :name, :type, :size
  json.url upload_url(upload, format: :json)
end
