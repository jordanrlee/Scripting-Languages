#require_relative "studentdata"

class RandomCSV

	def initialize(csv, size=:small)
		@csv = csv
		@csvFilePath = File.join("tmp", "aruba", @csv)
		@peopleFilePath = File.join("tmp", "aruba", @csv + ".people")
		@coursesFilePath = File.join("tmp", "aruba", @csv + ".courses")
		@firstNames = FIRSTNAMES
		@surNames = SURNAMES
		@cities = CITIES
		@states = STATES
		@zips = ZIPS
		@majors = MAJORS
		@courseNames = COURSES
		@termCodes = TERMCODES

		r = Random.new
		# determine number of students and classes
		if size == :small
			@peopleCount = r.rand(3..7)
			@courseCount = r.rand(2..5)
		else
			@peopleCount = r.rand(2..100)
			@courseCount = r.rand(5..20)
		end

		wnumber = 1
		@csvs = Array.new
		@people = Array.new
		@courses = Array.new
		for i in 1..@peopleCount
			if size == :small
				@courseCount = r.rand(2..3)
			else
				@courseCount = r.rand(5..20)
			end
			
			w = sprintf("W%07d", wnumber)
			f = @firstNames[r.rand(0..@firstNames.length-1)]
			s = @surNames[r.rand(0..@surNames.length-1)]
			m = @majors[r.rand(0..@majors.length-1)]
			c = @cities[r.rand(0..@cities.length-1)]
			st = @states[r.rand(0..@states.length-1)]
			z = @zips[r.rand(0..@zips.length-10)]
			student = %Q^#{w}|#{f}|#{s}|#{f}.#{s}@mail.weber.edu|#{m}|#{c}|#{st}|#{z}\n^
			@people << student

			for j in 1..rand(1..@courseCount)
				course = @courseNames[r.rand(0..@courseNames.length-1)]
				termcode = @termCodes[r.rand(0..@termCodes.length-1)]
				csv = %Q^"#{w}","#{f}","#{s}","#{f}.#{s}@mail.weber.edu","#{m}","#{course}","#{termcode}","#{c}","#{st}","#{z}"^
				@csvs << csv
				subjCode, courseNumber = course.split(" ")
				cls = %Q^#{w}|#{subjCode}|#{courseNumber}|#{termcode}\n^
				@courses << cls
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
		# create the courses output file
		coursesFile = File.open(@coursesFilePath, "w")
		@courses.each do |c|
			coursesFile.write(c)
		end
		coursesFile.close

		# create the people output file
		peopleFile = File.open(@peopleFilePath, "w")
		@people.each do |s|
			peopleFile.write(s)
		end
		peopleFile.close

	end

	def csvs
		return @csvs
	end
	def people
		return @people;
	end
	def courses
		return @courses
	end
	def peopleCount
		return @people.length
	end
	def coursesCount
		return @courses.length
	end
	def peopleFilePath
		return @peopleFilePath
	end
	def coursesFilepath
		return @coursesFilePath
	end
	
end
