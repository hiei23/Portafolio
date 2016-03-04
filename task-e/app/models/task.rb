class Task < ActiveRecord::Base
  belongs_to :user
  validates :user_id, presence: true

  def general_variables_prio
  	hoursleft = self.time_left
  	req_time = hoursleft - self.required_time
  	priotime = hoursleft / req_time
  	return priotime
  end

  def prioritycalc_general
  	self.priority = 1
  	priotime = self.general_variables_prio
  	if priotime <= 0
  		self.priority = 0
  	end
  	self.priority = self.priority * priotime * (self.weight*0.1+1) * (100-self.progress * (0.1+self.priority))
  	self.save
  end

  def prioritycalc_proglow
    self.priority = 1
    priotime = self.general_variables_prio
    if priotime <= 0
      self.priority = 0
    end
    self.priority = self.priority * priotime * (self.weight*0.1+1) * (100-self.progress * (0.02+self.priority)) 
    self.save
  end

  def prioritycalc_weightlow
    self.priority = 1
    priotime = self.general_variables_prio
    if priotime <= 0
      self.priority = 0
    end
    self.priority = self.priority * priotime * (self.weight*0.02+1) * (100-self.progress * (0.1+self.priority))
    self.save 
  end

  def call_priority_calc(algorithm)
    if algorithm == "1"
      self.prioritycalc_general
    elsif algorithm == "2"
      self.prioritycalc_proglow
    elsif algorithm == "3"
      self.prioritycalc_weightlow
    end
  end
	
  def time_left
	#time_now = Time.now
	#due_date = self.duedate
	#calculate and incorporate for all days of the month.
	#if time.month == 1 or time.month == 3 or time.month == 5 or time.month == 7 or time.month == 8 or time.month == 10 or time.month == 12
  	start_time = Time.now
  	end_time = self.due_date
  	return TimeDifference.between(start_time,end_time).in_hours
	end
end
