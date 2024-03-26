require 'httparty'

# Replace 'YOUR_API_KEY' with your actual API key obtained from ExchangeRate-API
API_KEY = 'YOUR_API_KEY'

def fetch_exchange_rate(source_currency, target_currency)
  url = "https://v6.exchangeratesapi.io/latest?base=#{source_currency}&symbols=#{target_currency}"
  response = HTTParty.get(url)
  exchange_data = JSON.parse(response.body)
  exchange_data['rates'][target_currency]
end

def convert_currency(amount, source_currency, target_currency)
  exchange_rate = fetch_exchange_rate(source_currency, target_currency)
  converted_amount = amount * exchange_rate
  converted_amount.round(2)
end

def main
  print "Enter source currency: "
  source_currency = gets.chomp.upcase
  print "Enter target currency: "
  target_currency = gets.chomp.upcase
  print "Enter amount to convert: "
  amount = gets.chomp.to_f

  converted_amount = convert_currency(amount, source_currency, target_currency)
  puts "#{amount} #{source_currency} is equivalent to #{converted_amount} #{target_currency}"
end

main