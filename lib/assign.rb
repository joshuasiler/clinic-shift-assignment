  class AssignTools
  
    def self.getDateObjects(nextdate,enddate)
      dates = []
      while nextdate < enddate
	if (nextdate.wday == 2 || nextdate.wday == 4)
	  dates << {:date => nextdate, :assigned => [], :alts => []}
	end
	nextdate = nextdate.advance(:days => 1)
      end
      dates
    end
    
    def self.checkSuitability(desired,shifts,date,daysback, maxshifts)
      debug = false #true if date == DateTime.parse('2009-12-22') && daysback < 3
      if desired.nil?
	desired = 10000
      end
      puts "desired: " + desired.to_s + " : shifts : " + shifts.count.to_s + " : max : " + maxshifts.to_s + " : back : " + daysback.to_s if debug
      if desired+1 > shifts.count && shifts.count < maxshifts+1 && !shifts.include?(date)
	ok = true
	shifts.each { |shift|
	  if (shift > date.advance(:days => -daysback) && shift < date) || (shift < date.advance(:days => daysback) && shift > date)
	    puts shift.to_s + " : " + date.advance(:days => -daysback).to_s if debug
	    puts shift.to_s + " : " + date.advance(:days => daysback).to_s if debug
	    puts "" if debug
	    ok = false
	  end
	  }
	 puts ok if debug
	 return ok
      else
	# puts 'nyet' if date == Date.parse("2009-10-22")
	return false
      end
    end
  
  end
  
  class Assigner
    
  def self.assign
    Requestedshift.connection.execute("update requestedshifts set assigned_flag = 0")
  
    max_assigned = EntityStore['max_assigned']
    max_alts = EntityStore['max_alts']
    max_per = EntityStore['max_per']
    enrollment = Enrollment.get_latest()
    shifts = {}
    
    alldates = AssignTools.getDateObjects(enrollment.start_date, enrollment.end_date)
    
    unfilleddates = alldates
    requests = Request.find_all_by_enrollment_id(enrollment.id, :all)
    puts "Requestors: " + requests.count.to_s
    puts "Target dates: " + unfilleddates.count.to_s
    # do one assignment pass
    (max_alts + max_assigned).times do
      alldates.each { | date |
	  candidates = Requestedshift.get_unassigned_requests(enrollment.id, date[:date])
	  # sort by number of shifts
	  candidates.each { |candidate|
	    
	     #puts candidate.request_id if candidate.request.email == 'chungjo@ohsu.edu'

	     if shifts[candidate.request.id].nil?
		shifts[candidate.request.id] = []
	     end
	     candidate[:shifts] = shifts[candidate.request.id].count
	    
	    }
	  candidates.sort!{ |x,y| x.shifts <=> y.shifts }
	  #candidates.each {|c| print c.shifts }
	  #puts ""
	  x = 0
	  
	  # Reduce number of weeks until all slots filled
	  day_restrict = 21
	  #puts "hai " + shifts[candidates[x].request.id].inspect if candidates[x].request.email = 'chungjo@ohsu.edu'
	  until (candidates[x].nil? || AssignTools.checkSuitability(candidates[x].request.shifts_desired,shifts[candidates[x].request.id],date[:date],day_restrict,max_per)) 
	    #puts AssignTools.checkSuitability(candidates[x].request.shifts_desired,shifts[candidates[x].request.id],date[:date],y,max_per)
	    x += 1
	  end
	 # puts "hai2 " +  shifts[candidates[x].request.id].inspect if !candidates[x].nil? && candidates[x].request.email == 'chungjo@ohsu.edu'
	  #puts candidates[x].request.email if date[:date] == Date.parse("2009-10-22")  && candidates[x].email = 'chungjo@ohsu.edu'

	  if candidates[x].nil?
	    # descrease allowe time till we find someone
	    while day_restrict > 0
	      day_restrict = day_restrict -1 
	      x = 0
	      until (candidates[x].nil? || AssignTools.checkSuitability(candidates[x].request.shifts_desired,shifts[candidates[x].request.id],date[:date],day_restrict,max_per)) 
		#puts AssignTools.checkSuitability(candidates[x].request.shifts_desired,shifts[candidates[x].request.id],date[:date],y,max_per)
		x += 1
		#puts x if date[:date] == Date.parse("2009-12-22")
	      end
	    end
	  end
	  if candidates[x].nil?
	    # increase max shifts till we find someone
	    maxxed = max_per
	    while maxxed < 40
		maxxed = maxxed  + 1 
		x = 0
		until (candidates[x].nil? || AssignTools.checkSuitability(candidates[x].request.shifts_desired,shifts[candidates[x].request.id],date[:date],day_restrict,maxxed)) 
		  #puts AssignTools.checkSuitability(candidates[x].request.shifts_desired,shifts[candidates[x].request.id],date[:date],y,max_per)
		  x += 1
		  #puts x if date == Date.parse("2009-12-22")
		end
	      end 
	  end
	
	  #puts candidates[x].request.email unless candidates[x].nil? # || candidates[x].request.email != "bee@ohsu.edu"
	  if candidates[x].nil?
	    puts "ran out of people on: " + date[:date].to_s
	  else
	    date[:assigned] << candidates[x]
	    shifts[candidates[x].request.id] << date[:date]
	   # puts "hai3 " +  shifts[candidates[x].request.id].inspect if candidates[x].request.email == 'chungjo@ohsu.edu'
	
	    if date[:assigned].count < max_assigned +1
	      candidates[x].assigned_flag = 1
	    else
	      candidates[x].assigned_flag = 2
	    end
	    candidates[x].save
	  end
	  #puts date[:date].to_s + " :: " + candidates.count.to_s + " :: " + date[:assigned].count.to_s
      }
	
   end
   #puts max_alts + max_assigned
  
    counter = {}
    #puts alldates.inspect
    alldates.each { | date |
      print date[:date].to_s + ", "
      z=1
      date[:assigned].each { |assigned|
	if counter[assigned.request.email].nil?
	  counter[assigned.request.email] = {:alts => 0, :assigned => 0}
	end
	if z <max_assigned + 1
	  counter[assigned.request.email][:assigned] += 1
	else
	  counter[assigned.request.email][:alts] += 1
	end
	print assigned.request.email + ", "
	z += 1
      }
       puts ""
    }
    
    
    shifts.each { |key,value|
      print Request.find(key).email + ", avaliable: " + Request.find(key).days_requested[0].requested_dates
      print " days, wanted: " + Request.find(key).shifts_desired.to_s + " shifts, assigned: "
      unless counter[Request.find(key).email].nil?
	print counter[Request.find(key).email][:assigned].to_s
	print " and alts: " +  counter[Request.find(key).email][:alts].to_s
      end
      print "\n" 
      }
    
  end
  end