require 'httparty'

# Replace 'YOUR_API_KEY' with your actual API key obtained from Eventbrite
API_KEY = 'YOUR_API_KEY'

def fetch_events(city)
  url = "https://www.eventbriteapi.com/v3/events/search/?location.address=#{city}&token=#{API_KEY}"
  response = HTTParty.get(url)
  events_data = JSON.parse(response.body)
  events_data['events']
end

def display_events(events)
  if events.empty?
    puts "No events found."
  else
    puts "Upcoming Events:"
    events.each do |event|
      puts "Name: #{event['name']['text']}"
      puts "Venue: #{event['venue']['name']}"
      puts "Date: #{event['start']['local']}"
      puts "Time: #{event['start']['time']}"
      puts "----------------------"
    end
  end
end

def main
  print "Enter city name: "
  city = gets.chomp

  puts "Fetching events in #{city}..."
  events = fetch_events(city)
  display_events(events)
end

main