json.extract! message, :id, :senderId, :recipientId, :mid, :status, :timestamp, :body, :created_at, :updated_at
json.url message_url(message, format: :json)
