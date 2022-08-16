Given /^OUTPUT is printed/ do
    stdoutOutput = all_commands.map { |c| c.stdout }.join("\n").strip
    if stdoutOutput != ""
        log "STDOUT>>>"
        log stdoutOutput
        log "<<<STDOUT"
    else
        log "STDOUT is EMPTY"
    end
    stderrOutput = all_commands.map { |c| c.stderr }.join("\n").strip
    if stderrOutput != ""
        log "STDERR>>>"
        log stderrOutput
        log "<<<STDERR"
    else
        log "STDERR is EMPTY"
    end
end

Given /^a random small CSV file "(.*)"$/ do |csv|
	#log "Building #{csv}"
	@csv = RandomCSV.new(csv, :small)
	#log "People:#{@csv.peopleCount}"
end

Given /^the courses table in "(.*)" should be defined correctly$/ do |db|
	dbPath = File.join("tmp","aruba",db)
	create = `sqlite3 #{dbPath} 'select count(*) from courses'`
	if create.match(/no such table/i)
		raise "#{db} does not have table 'courses' defined"
	end
	create = `sqlite3 #{dbPath} '.schema courses'`
	checkFor = "id text"
	if !create.match(/#{checkFor}/i)
		raise "#{db} table courses does not include column '#{checkFor}'"
	end
	checkFor = "subjcode text"
	if !create.match(/#{checkFor}/i)
		raise "#{db} table courses does not include column '#{checkFor}'"
	end
	checkFor = "coursenumber text"
	if !create.match(/#{checkFor}/i)
		raise "#{db} table courses does not include column '#{checkFor}'"
	end
	checkFor = "termcode text"
	if !create.match(/#{checkFor}/i)
		raise "#{db} table courses does not include column '#{checkFor}'"
	end
end


Given /^the people table in "(.*)" should be defined correctly$/ do |db|
	dbPath = File.join("tmp","aruba",db)
	create = `sqlite3 #{dbPath} 'select count(*) from people'`
	if create.match(/no such table/)
		raise "#{db} does not have table 'people' defined"
	end
	create = `sqlite3 #{dbPath} '.schema people'`
	checkFor = "id text primary key unique"
	if !create.match(/#{checkFor}/i)
		raise "#{db} table people does not include column '#{checkFor}'"
	end
	checkFor = "firstname text"
	if !create.match(/#{checkFor}/i)
		raise "#{db} table people does not include column '#{checkFor}'"
	end
	checkFor = "lastname text"
	if !create.match(/#{checkFor}/i)
		raise "#{db} table people does not include column '#{checkFor}'"
	end
	checkFor = "major text"
	if !create.match(/#{checkFor}/i)
		raise "#{db} table people does not include column '#{checkFor}'"
	end
	checkFor = "email text"
	if !create.match(/#{checkFor}/i)
		raise "#{db} table people does not include column '#{checkFor}'"
	end
	checkFor = "city text"
	if !create.match(/#{checkFor}/i)
		raise "#{db} table people does not include column '#{checkFor}'"
	end
	checkFor = "state text"
	if !create.match(/#{checkFor}/i)
		raise "#{db} table people does not include column '#{checkFor}'"
	end
	checkFor = "zip text"
	if !create.match(/#{checkFor}/i)
		raise "#{db} table people does not include column '#{checkFor}'"
	end
end

Given /^the count of people from "(.*)" in "(.*)" should be correct$/ do |csv, db|
	dbPath = File.join("tmp","aruba",db)
	count = `sqlite3 #{dbPath} 'select count(*) from people'`
	if count.match(/error/i) or $?.to_i > 0
		raise "Error rc=#{$?.to_i} returned from sqlite3: #{count}"
	else
		if count.to_i != @csv.peopleCount
			raise "Your people table contains #{count.to_i} rows but should contain #{@csv.peopleCount}"
		end
	end
end
	
Given /^the count of courses from "(.*)" in "(.*)" should be correct$/ do |csv, db|
	dbPath = File.join("tmp","aruba",db)
	count = `sqlite3 #{dbPath} 'select count(*) from courses'`
	if count.match(/error/i) or $?.to_i > 0
		raise "Error rc=#{$?.to_i} returned from sqlite3: #{count}"
	else
		if count.to_i != @csv.coursesCount
			raise "Your courses table contains #{count.to_i} rows but should contain #{@csv.coursesCount}"
		end
	end
end
	
Given /^the people table data from "(.*)" in "(.*)" should be correct$/ do |csv, db|
	#dbPath = File.join("tmp","aruba",db)
	dbPath = db
	selectStmt = "select id,firstname,lastname,email,major,city,state,zip from people order by id;"
	# remember Ted that when using 'step' you don't prepend the path
	step "I run `sqlite3 #{dbPath} '#{selectStmt}'`"
	step "the output should not contain \"Error\""
	temp_output = all_commands.map { |c| c.output }.join("\n")
	#log "Output:\n#{temp_output}"
	if not temp_output.include? @csv.people.join("")
		log "Your people data:\n#{temp_output}\n\nExpected people data:\n#{@csv.people.sort.join("")}"
		raise "People data in #{db} not as expected"
	end
	
	#pending #todo: call sqlite3 to extract and sort a count of records in his people table and compare them to my people table
end
	
Given /^the courses table data from "(.*)" in "(.*)" should be correct$/ do |csv, db|
	#dbPath = File.join("tmp","aruba",db)
	dbPath = db
	selectStmt = "select id,subjcode,coursenumber,termcode from courses order by id,subjcode,coursenumber,termcode;"
	# remember Ted that when using 'step' you don't prepend the path
	step "I run `sqlite3 #{dbPath} '#{selectStmt}'`"
	step "the output should not contain \"Error\""
	temp_output = all_commands.map { |c| c.output }.join("\n")
	#log "Output:\n#{temp_output}"
	if not temp_output.include? @csv.courses.sort.join("")
		log "Your courses data:\n#{temp_output}\n\nExpected people data:\n#{@csv.courses.sort.join("")}"
		raise "Courses data in #{db} not as expected"
	end
	
	#pending #todo: call sqlite3 to extract and sort a count of records in his people table and compare them to my people table
end
	
Given /^(.*) points are awarded/ do |points|
	#log "#{points} points are now awarded!!!"
	$total_points += points.to_i
end

Given /^timeout is increased by (.*) seconds$/ do |seconds|
	if @aruba_timeout_seconds  
		@aruba_timeout_seconds += seconds.to_i
	else
		log "aruba_timeout_seconds is NIL!"
	end
end

Given /^timeout is decreased by (.*) seconds$/ do |seconds|
	if @aruba_timeout_seconds
		@aruba_timeout_seconds -= seconds.to_i
	else
		log "aruba_timeout_seconds is NIL!"
	end
end

