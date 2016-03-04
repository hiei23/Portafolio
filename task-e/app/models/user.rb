class User < ActiveRecord::Base
	has_many :tasks
	before_save {email.downcase!}
  	validates :name, presence: true, length: {maximum: 50}
  	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  	validates :email, presence: true, format: {with: VALID_EMAIL_REGEX}, uniqueness: {case_sensitive: false}
  	has_secure_password
  	validates :password, presence: true, length: {minimum: 6}, allow_nil: true

	def calcalltasks(algorithm)
		for task in self.tasks do
			task.call_priority_calc(algorithm)
		end
	end

	def calcTotalHours
		totalHours = 0
		for task in self.tasks do
			totalHours = totalHours + task.required_time
		end
		return totalHours
	end

	def calcMinDailyHrs
		minHrs = 0
		for task in self.tasks do
			if task.time_left < 24
				minHrs = minHrs + task.required_time
			end
		end
		return minHrs
	end

	def calcMinWeekHrs
		minHrs = 0
		for task in self.tasks do
			if task.time_left < 168
				minHrs = minHrs + task.required_time
			end
		end
		return minHrs
	end

	def calcMinMonthHrs
		minHrs = 0
		for task in self.tasks do
			if task.time_left < 744
				minHrs = minHrs + task.required_time
			end
		end
		return minHrs
	end

	def getTodayTasks
		tasksSub = Array.new
		for task in self.tasks do
			if task.time_left <= 24
				tasksSub << task
			end
		end
		return tasksSub
	end

	def getWeekTasks
		tasksSub = Array.new
		for task in self.tasks do
			if task.time_left > 24 and task.time_left <= 168
				tasksSub << task
			end
		end
		return tasksSub
	end

	def getMonthTasks
			tasksSub = Array.new
			for task in self.tasks do
				if task.time_left > 168 and task.time_left <= 744
					tasksSub << task
				end
			end
			return tasksSub
		end

	def search(search)
		if search
	  		self.tasks.where('tag LIKE ?', "%#{search}%")
		else
	  		self.tasks.all
		end
  	end

end
