class Request < ActiveRecord::Base
  def self.get_existing(email,curen)
    Request.find_by_sql(["select * from requests where email = ? and enrollment_id = ?",email,curen])[0]
  end
  
  def self.get_priorities(curen)
    Request.find_by_sql(["select a.*,count(*) from requests a inner join requestedshifts b on a.id=b.request_id and enrollment_id = ? group by email order by count(*) desc",curen])
  end
end
