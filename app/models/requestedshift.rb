class Requestedshift < ActiveRecord::Base
  def self.get_request(reqid,day)
    Requestedshift.find_by_sql(["select * from requestedshifts where request_id=? and DAY(target_date)=?",reqid,day])
  end
  
  def self.get_assigned(date)
    Requestedshift.find_by_sql(["select * from requestedshifts a inner join requests b on a.request_id = b.id where (assigned_flag =1 or assigned_flag=2) and DAY(target_date)=? and b.enrollment_id = ? order by assigned_flag",date.day.to_s,Enrollment.get_latest.id])
  end
end
