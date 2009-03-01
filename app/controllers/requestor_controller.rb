class RequestorController < ApplicationController
  def make_request
    @enrollment = Enrollment.get_latest()
    @datectrl = @enrollment.start_date
    @dateend = @enrollment.end_date+1
    @thismonth = @datectrl.month
  end
  
  def process_request
    # processes request forms
    enrollment = Enrollment.get_latest()
    if params['email'].empty? || params['name'].empty?
      flash[:message] = "A valid email address and a name is required."
      redirect_to :action => :make_request
    else
    
      r = Request.get_existing(params['email'],enrollment.id)
      if r.nil?
	r = Request.new
	r.email = params['email']
	r.enrollment_id = enrollment.id
      else
	Requestedshift.delete_all(["request_id=?",r.id])
      end
      r.name = params['name']
      r.req_type = params['type']
      r.shifts_desired = params['maxshifts']
      r.save
      
      enrollment = Enrollment.get_latest()
      datectrl = enrollment.start_date
      dateend = enrollment.end_date+1
      while datectrl< dateend
	if params["s"+datectrl.month.to_s + "-" + datectrl.day.to_s] == "1"
	  rs = Requestedshift.new
	  rs.request_id = r.id
	  rs.target_date = datectrl
	  rs.save
	end
	datectrl = datectrl + 1 
      end
    end
  end
end
