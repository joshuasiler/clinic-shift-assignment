class AdminController < ApplicationController
  def index
     @enrollment = Enrollment.get_latest()
    @reqs = Request.count_by_sql(["select count(*) from requests where enrollment_id=?",@enrollment.id])

    @datectrl = @enrollment.start_date
    @dateend = @enrollment.end_date+1
    @thismonth = @datectrl.month
  end
  
  def reopen
    cv = ConfigValue.find_by_key('req_open')
    cv.value = 1
    cv.save
    redirect_to :action => :index
  end
  
  def open_req
    en = Enrollment.new
    en.start_date = Date.parse(params['start_date'])
    en.end_date = Date.parse(params['end_date'])
    unless (en.start_date.nil? or en.end_date.nil?)
      en.save
      cv = ConfigValue.find_by_key('req_open')
      cv.value = 1
      cv.save
    end
    redirect_to :action => :index
  end
  
  def set_calendar
    # processes requests and sets calendar
    reqs = Request.get_priorities()
    enrollment = Enrollment.get_latest()
    datectrl = enrollment.start_date
    dateend = enrollment.end_date+1
    thismonth = datectrl.month
    while datectrl < dateend
	assigned = 0;
	alts = 0;
	reqs.each do |req|
	  Requestedshift.connection.execute("update requestedshifts set assigned_flag = 0 where request_id =#{req.id} and target_date = '#{datectrl.to_s}'")
	  if req.shifts_desired.nil?
	    req.shifts_desired = 1000
	  end
	  unless req.shifts_desired == 0
	    shift = Requestedshift.get_request(req.id,datectrl.day)
	    unless shift[0].nil?
	      req.shifts_desired -= 1
	      if assigned < 2
		shift[0].assigned_flag = 1
		assigned += 1
	      else
		shift[0].assigned_flag = 2
		alts += 1
	      end
	      shift[0].save
	      if assigned == 2 && alts == 2
		break
	      end
	    end
	  end
	end
	    
      datectrl = datectrl+1
    end
    cv = ConfigValue.find_by_key('req_open')
    cv.value = 0
    cv.save
    redirect_to :action => :index
  end
end
