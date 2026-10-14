json.extract! monitored_api, :id, :name, :url, :expected_status, :created_at, :updated_at
json.url monitored_api_url(monitored_api, format: :json)
