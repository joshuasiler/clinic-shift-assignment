class CalendarController < ApplicationController
  def index
    @enrollment = Enrollment.get_latest()
    @last_enrollment = Enrollment.get_last()
    @datectrl = @enrollment.start_date
    @dateend = @enrollment.end_date+1
    @thismonth = @datectrl.month
  end
end
