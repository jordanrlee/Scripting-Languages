#require_relative "studentdata"

class RandomCSV

	def initialize(csv, size=:small)
		@csv = csv
		@csvFilePath = File.join("tmp", "aruba", @csv)
		@studentsFilePath = File.join("tmp", "aruba", @csv + ".students")
		@classesFilePath = File.join("tmp", "aruba", @csv + ".classes")
		@firstNames = FIRSTNAMES
		@surNames = SURNAMES
		@cities = CITIES
		@states = STATES
		@zips = ZIPS
		@majors = MAJORS
		@courses = COURSES
		@termCodes = TERMCODES

		r = Random.new
		# determine number of students and classes
		if size == :small
			@studentCount = r.rand(3..7)
			@classCount = r.rand(2..5)
		else
			@studentCount = r.rand(2..100)
			@classCount = r.rand(5..20)
		end

		wnumber = 1
		@csvs = Array.new
		@students = Array.new
		@classes = Array.new
		for i in 1..@studentCount
			if size == :small
				@classCount = r.rand(2..3)
			else
				@classCount = r.rand(5..20)
			end
			
			w = sprintf("W%07d", wnumber)
			f = @firstNames[r.rand(0..@firstNames.length-1)]
			s = @surNames[r.rand(0..@surNames.length-1)]
			m = @majors[r.rand(0..@majors.length-1)]
			c = @cities[r.rand(0..@cities.length-1)]
			st = @states[r.rand(0..@states.length-1)]
			z = @zips[r.rand(0..@zips.length-10)]
			student = %Q^#{w}|#{f}|#{s}|#{f}.#{s}@mail.weber.edu|#{m}|#{c}|#{st}|#{z}\n^
			@students << student

			for j in 1..rand(1..@classCount)
				course = @courses[r.rand(0..@courses.length-1)]
				termcode = @termCodes[r.rand(0..@termCodes.length-1)]
				csv = %Q^"#{w}","#{f}","#{s}","#{m}","#{f}.#{s}@mail.weber.edu","#{course}","#{termcode}","#{c}","#{st}","#{z}"^
				@csvs << csv
				subjCode, courseNumber = course.split(" ")
				cls = %Q^#{w}|#{subjCode}|#{courseNumber}|#{termcode}\n^
				@classes << cls
			end
			wnumber += 1
		end
		# create the csv file
		csvFile = File.open(@csvFilePath, "w")
		csvFile.write(%Q^wnumber,firstname,lastname,email,major,course,termcode,city,state,zip\n^)
		csvs.each do |c|
			csvFile.write(c+"\n")
		end
		csvFile.close		
		# create the classes output file
		classesFile = File.open(@classesFilePath, "w")
		@classes.each do |c|
			classesFile.write(c)
		end
		classesFile.close

		# create the students output file
		studentsFile = File.open(@studentsFilePath, "w")
		@students.each do |s|
			studentsFile.write(s)
		end
		studentsFile.close

	end

	def csvs
		return @csvs
	end
	def students
		return @students;
	end
	def classes
		return @classes
	end
	def studentCount
		return @students.length
	end
	def classCount
		return @classes.length
	end
	def studentsFilePath
		return @studentsFilePath
	end
	def classesFilepath
		return @classesFilePath
	end
	
end
