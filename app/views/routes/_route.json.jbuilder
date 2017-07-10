json.extract! route, :id, :source, :destination, :created_at, :updated_at
json.url route_url(route, format: :json)
