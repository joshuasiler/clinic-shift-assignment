
require 'assign.rb'
class AdminController < ApplicationController
  def index
     @enrollment = Enrollment.get_latest()
    @reqs = Request.count_by_sql(["select count(*) from requests where enrollment_id=?",@enrollment.id])

    @datectrl = @enrollment.start_date
    @dateend = @enrollment.end_date+1
    @thismonth = @datectrl.month
  end
  
  def reopen
    EntityStore['req_open'] = 1
  	redirect_to :action => :index
  end
  
  def open_req
    en = Enrollment.new
    en.start_date = Date.parse(params['start_date'])
    en.end_date = Date.parse(params['end_date'])
    unless (en.start_date.nil? or en.end_date.nil?)
      en.save
      EntityStore['req_open'] = 1
    end
    redirect_to :action => :index
  end
  
  
  def set_calendar
    Assigner.assign()
    EntityStore['req_open'] = 0
     redirect_to :action => :index
  end
  
	def close
		EntityStore['req_open'] = 0
     redirect_to :action => :index
	end
  
end
