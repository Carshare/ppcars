json.array!(@cars) do |car|
  json.extract! car, :id, :available, :cover_photo, :car_id, :make, :module, :overall, :price_daily, :price_hourly, :price_weekly, :region, :street, :year
  json.url car_url(car, format: :json)
end
