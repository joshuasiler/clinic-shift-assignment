class RequestorController < ApplicationController
  def make_request
    @datectrl = Date.parse(ConfigValue.find_by_key('active_month').value)
    @thismonth = @datectrl.month
  end
  
  def process_request
    # processes request forms
    
    r = Request.get_existing(params['email'],ConfigValue.find_by_key('active_month').value)
    if r.nil?
      r = Request.new
      r.email = params['email']
      r.target_month = ConfigValue.find_by_key('active_month').value
    else
      Requestedshift.delete_all(["request_id=?",r.id])
    end
    r.req_type = params['type']
    r.shifts_desired = params['maxshifts']
    r.save
    
    datectrl = Date.parse(ConfigValue.find_by_key('active_month').value)
    thismonth = datectrl.month
    while datectrl.month == thismonth
      unless params["shift"+datectrl.day.to_s].empty?
	rs = Requestedshift.new
	rs.request_id = r.id
	rs.target_date = datectrl
	rs.target_shift = params["shift"+datectrl.day.to_s]
	rs.save
      end
      datectrl = datectrl + 1 
    end
    
  end
end
