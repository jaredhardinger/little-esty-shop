class HolidayFacade 

  def holiday_info
   holiday_request = HolidayService.new
   holidays = []
   holiday_request.api_request.each do |holiday|
    holidays << Holiday.new(holiday)
   end
   holidays   
  end
end