class Request < ActiveRecord::Base
  attr_accessor :assigned_shifts
  before_create :check_shifts
  
  def self.get_existing(email,curen)
    Request.find_by_sql(["select * from requests where email = ? and enrollment_id = ?",email,curen])[0]
  end
  
  def self.get_priorities(curen)
    Request.find_by_sql(["select a.*,count(*) from requests a inner join requestedshifts b on a.id=b.request_id and enrollment_id = ? group by email order by shifts_desired, count(*) asc",curen])
  end
  
  def check_shifts
    if self.shifts_desired.nil?
      self.shifts_desired = 10000
    end
  end
  
end
