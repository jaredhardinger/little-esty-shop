require 'httparty'
class HolidayService 

  def api_request
    response = HTTParty.get('https://date.nager.at/api/v3/nextpublicholidays/us')
    JSON.parse(response.body, symbolize_names: true)
  end
end