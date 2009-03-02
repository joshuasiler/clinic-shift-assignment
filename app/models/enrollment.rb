class Enrollment < ActiveRecord::Base
  def self.get_latest()
    Enrollment.find_by_sql("select * from enrollments order by id desc limit 1")[0]
  end
  def self.get_last()
    begin
      Enrollment.find_by_sql("select * from enrollments order by id desc limit 1")[1]
    rescue
      nil
    end
  end
end
