class Request < ActiveRecord::Base
  attr_accessor :assigned_shifts
  before_create :check_shifts
  has_many :requestedshifts
  
  def self.get_existing(email,curen)
    Request.find_by_sql(["select * from requests where email = ? and enrollment_id = ?",email,curen])[0]
  end
  
  def check_shifts
    if self.shifts_desired.nil?
      self.shifts_desired = 10000
    end
  end
  
  def days_requested
    Request.find_by_sql(["select a.email,a.shifts_Desired,count(*) as requested_dates from requests a left outer join requestedshifts b on a.id = b.request_id where enrollment_id = 13 and a.id = ? group by email, shifts_desired order by requested_dates desc",self.id])
  end
end
