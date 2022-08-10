class HolidayFacade

  def holiday_information
    service.holidays.shift(3).map { |data| Holiday.new(data)}
  end

  def service
    HolidayService.new
  end
end
