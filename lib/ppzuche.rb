require "net/http"
require "uri"

class Ppzuche
  def self.load_cars(pages, option={})
    pages.each do |page|
      start_date = option[:start_date] || '2014-02-18'
      start_time = '15:00'
      end_date = option[:end_date] || '2014-02-19'
      end_time = '15'
      sort = 'price'
    
      url = "http://www.ppzuche.com/ajax_get_car_list?date_start=#{start_date}&begin=#{start_time}&date_end=#{end_date}&end=#{end_time}&sort=#{sort}&keyword=&lat=&lng=&seats=0&gps=0&audio_input=0&make=0&transmission=0&car_id=0&page=#{page}"
      uri = URI.parse(url)
      
      puts 'reading ' + url
      
      response = Net::HTTP.get_response(uri)
    
      json_body = Oj.load(response.body)
      cars_data = json_body["cars"]
      
      if cars_data.empty?
        break
      else
        puts 'count: ' + cars_data.count.to_s
      end
    
      # available: 1
      # cover_photo: "/thumbs/static/uploads/14988/1389406049-tNIp9siK.JPG?size=150x105"
      # id: "G0JV0NX9EwNb"
      # make: "起亚"
      # module: "千里马"
      # overall: 4
      # price_daily: "￥ 80"
      # price_hourly: "￥ 10"
      # price_weekly: "￥ 480"
      # region: ""
      # street: "中关村一桥"
      # year: "2006"
    
      cars_data.each do |car_data|
        Car.find_or_create_by(car_id: car_data["id"],
                              cover_photo: car_data["cover_photo"],
                              make: car_data["make"],
                              module: car_data["module"],
                              overall: car_data["overall"].to_i,
                              price_daily: parse_price(car_data["price_daily"]),
                              price_hourly: parse_price(car_data["price_hourly"]),
                              price_weekly: parse_price(car_data["price_weekly"]),
                              region: car_data["region"],
                              street: car_data["street"],
                              year: car_data["year"].to_i)
      end
    end
  end
  
  private
  
  def self.parse_price price_text
    (price_text[/(\d)+/]).to_i
  end
end