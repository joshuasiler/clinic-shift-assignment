class Requestedshift < ActiveRecord::Base
  def self.get_request(shift,reqid,day)
    Requestedshift.find_by_sql(["select * from requestedshifts where target_shift=? and request_id=? and DAY(target_date)=?",shift,reqid,day])
  end
  
  def self.get_assigned(shift,day)
    Requestedshift.find_by_sql(["select * from requestedshifts where assigned_flag =1 and target_shift=? and DAY(target_date)=?",shift,day])
  end
end
