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
    enrollment = Enrollment.get_latest()
    
	  # clear out all previously assigned shifts
	  # facilitates reruns
	  Requestedshift.connection.execute("update requestedshifts set assigned_flag = 0") # where target_date = '#{datectrl.to_s}'")

    # arbitrary number for first pass through loop
    unclaimed_shifts = 10
    # one less than the number of shifts for first pass   
    max_shifts = 0
    # monitor to check if unclaimed stops improving with multiple passes
    last_unclaimed_shifts = 0
		assignedcnts = {}    
		altcnts = {}
    while unclaimed_shifts > 0 && last_unclaimed_shifts != unclaimed_shifts
      reqs = Request.get_priorities(enrollment.id)
      
      last_unclaimed_shifts = unclaimed_shifts
      unclaimed_shifts = 0
      max_shifts += 1
      datectrl = enrollment.start_date
      dateend = enrollment.end_date+1
      thismonth = datectrl.month
      reqs.each do |req|
				req.assigned_shifts = 0
				if req.shifts_desired.nil?
					req.shifts_desired = 1000
				end
      end
      while datectrl < dateend
	
	#Tuesdays and Thursdays only
	if (datectrl.wday == 2 || datectrl.wday == 4) && !(assignedcnts[datectrl] == ConfigValue.find_by_key('max_assigned').value.to_i &&  altcnts[datectrl] == ConfigValue.find_by_key('max_alts').value.to_i)
	  # for each day in the range
		if assignedcnts[datectrl].nil?
			assignedcnts[datectrl] = 0
		end
	 	if altcnts[datectrl].nil?
      altcnts[datectrl] = 0
    end

	  # check all requests for suitability
	  reqs.each do |req|
	    unless req.shifts_desired == 0 || req.assigned_shifts == max_shifts && !( assignedcnts[datectrl] == ConfigValue.find_by_key('max_assigned').value.to_i &&  altcnts[datectrl] == ConfigValue.find_by_key('max_alts').value.to_i)
	      # check and see if this person is a match
	      shift = Requestedshift.get_request(req.id,datectrl)
	      unless shift[0].nil?
					# is this person requesting any for this day    
					req.shifts_desired -= 1
					req.assigned_shifts += 1
					if assignedcnts[datectrl] < ConfigValue.find_by_key('max_assigned').value.to_i
		  			shift[0].assigned_flag = 1
		  			assignedcnts[datectrl] += 1
					else
						if altcnts[datectrl] < ConfigValue.find_by_key('max_alts').value.to_i
			  			shift[0].assigned_flag = 2
			  			altcnts[datectrl] += 1
						else
							# didn't actually get a shift		
							req.shifts_desired += 1
		          req.assigned_shifts -= 1
						end
					end
					shift[0].save
	      end
	    end
	  end
	  # unclaimed tues/thurs
    unclaimed_shifts += ConfigValue.find_by_key('max_assigned').value.to_i- assignedcnts[datectrl] + ConfigValue.find_by_key('max_alts').value.to_i-altcnts[datectrl]
	end
	# move to the next day in range
	datectrl = datectrl+1
      end
    end
    ConfigValue.set_key('req_open',0)
    redirect_to :action => :index
  end
  
  private
  
  
end
