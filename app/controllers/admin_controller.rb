class AdminController < ApplicationController
  def index
    @reqs = Request.count_by_sql(["select count(*) from requests where target_month=?",ConfigValue.find_by_key('active_month').value])
    @datectrl = Date.parse(ConfigValue.find_by_key('active_month').value)<<1
    @thismonth = @datectrl.month
  end
  
  def set_calendar
    # processes requests and sets calendar
    reqs = Request.get_priorities()
    datectrl = Date.parse(ConfigValue.find_by_key('active_month').value)
    thismonth = datectrl.month
    while datectrl.month == thismonth
      
      SHIFTS.each do |shift|
	
	reqs.each do |req|
	  shifts = Requestedshift.get_request(shift,req.id,datectrl.day)
	  unless shifts.empty?
	    shifts[0].assigned_flag = 1
	    shifts[0].save
	    break
	  end
	end
	
      end
      
      datectrl = datectrl+1
    end
    cv = ConfigValue.find_by_key('active_month')
    cv.value = Date::MONTHNAMES[(Date.parse(cv.value)>>1).month] + " " + (Date.parse(cv.value)>>1).year.to_s
    cv.save
    redirect_to :action => :index
  end
end
