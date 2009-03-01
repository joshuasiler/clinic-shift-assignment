class Request < ActiveRecord::Base
  def self.get_existing(email,curmonth)
    Request.find_by_sql(["select * from requests where email = ? and target_month = ?",email,curmonth])[0]
  end
  
  def self.get_priorities()
    Request.find_by_sql("select a.*,count(*) from requests a inner join requestedshifts b on a.id=b.request_id group by email order by count(*) desc")
  end
end
