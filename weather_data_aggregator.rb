require 'httparty'

# Replace 'YOUR_API_KEY' with your actual API key obtained from OpenWeatherMap
API_KEY = 'YOUR_API_KEY'

def fetch_weather_data(city)
  url = "http://api.openweathermap.org/data/2.5/weather?q=#{city}&appid=#{API_KEY}&units=metric"
  response = HTTParty.get(url)
  weather_data = JSON.parse(response.body)
  weather_data
end

def calculate_average_temperature(weather_data_list)
  total_temperature = weather_data_list.sum { |data| data['main']['temp'] }
  average_temperature = total_temperature / weather_data_list.length
  average_temperature.round(2)
end

def main
  print "Enter city name: "
  city = gets.chomp

  puts "Fetching weather data for #{city}..."

  # Assuming we collect weather data every hour for 24 hours
  weather_data_list = []

  # Collect weather data for 24 hours
  24.times do
    weather_data = fetch_weather_data(city)
    weather_data_list << weather_data
    sleep(3600) # Sleep for an hour (in seconds)
  end

  average_temperature = calculate_average_temperature(weather_data_list)
  puts "Average temperature in #{city} over 24 hours: #{average_temperature}°C"
end

main