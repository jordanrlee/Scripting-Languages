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

Given /^a random logfile named (.*)/ do |logfile|
	@log = BuildLog.new(logfile)
end

Given /^header contains "(.*?)"$/ do |arg1|
	#step "the output should match /SearchReport\s+#{hostname}\s+#{@testFiles.topFolder}/"
	temp_output = all_commands.map { |c| c.output }.join("\n")
	if !temp_output.match(/#{arg1}/)
		raise("Output <#{temp_output}> does not contain \"#{arg1}\"")	
	end
end

Given /^I pipe the output to a web browser/ do
	tempFile = File.join("tmp/aruba", "tempoutput")
	temp_output = all_commands.map { |c| c.output }.join("\n")
	open(tempFile, 'w') { |f|
		f << temp_output 
	}
	step "I run `lynx -dump #{tempFile}`"
	File.delete(tempFile)
end

Given /^the output should be sorted and complete/ do
	users = @log.users
	#output = all_output
	# remove the first two rows
	#log all_output
	output = Array.new
	temp_output = all_commands.map { |c| c.output }.join("\n")
	output = temp_output.split("\n")
	savedOutput = Array.new
	temp_output = all_commands.map { |c| c.output }.join("\n")
	savedOutput = temp_output.split("\n")
	output.delete_at(0)
	output.delete_at(0)
	if users.length != output.length
		log "Your output:"
		for i in 1..savedOutput.length
			log "Line #{i}: #{savedOutput[i-1]}"
		end
		log
		raise("#{output.length} rows of data (less the header) found in output but #{users.length} expected")
	end
	for i in 0..output.length-1
		if output[i].sub(',','').match(/#{users[i].count}[ ]+#{users[i].userid}/) == nil
			log "Your output:"
			for n in 1..savedOutput.length
				log "Line #{n}: #{savedOutput[n-1]}"
			end
			log "\nExpected output (minus the header line):"
			for n in 1..users.length-1
		        commaCount = users[n-1].count.to_s.gsub(/(\d)(?=(\d\d\d)+(?!\d))/, "\\1,")
				log "Line #{n}: #{commaCount} #{users[n-1].userid}"
			end
		    commaCount = users[i].count.to_s.gsub(/(\d)(?=(\d\d\d)+(?!\d))/, "\\1,")
			raise("'#{output[i]}' should be '#{commaCount} #{users[i].userid}'")
		end
	end
end

Given /^large numbers are punctuated with commas/ do
	users = @log.users
	# remove the first two rows
	output = Array.new
	temp_output = all_commands.map { |c| c.output }.join("\n")
	output = temp_output.split("\n")
	savedOutput = Array.new
	temp_output = all_commands.map { |c| c.output }.join("\n")
	savedOutput = temp_output.split("\n")
	output.delete_at(0)
	output.delete_at(0)
	if users.length != output.length
		log "Your output:"
		for i in 1..savedOutput.length
			log "Line #{i}: #{savedOutput[i-1]}"
		end
		log
		raise("#{output.length} rows of data (less the header) found in output but #{users.length} expected")
	end
	for i in 0..output.length-1
		commaCount = users[i].count.to_s.gsub(/(\d)(?=(\d\d\d)+(?!\d))/, "\\1,")
		if output[i].match(/#{commaCount}[ ]+#{users[i].userid}/) == nil
			log "Your output:"
			for n in 1..savedOutput.length
				log "Line #{n}: #{savedOutput[n-1]}"
			end
			raise("'#{output[i]}' should have commas like this: '#{commaCount} #{users[i].userid}'")
		end
	end
end

Given /^header ends with the current date$/ do
=begin
	date = `date`.chomp
	hostname = `hostname`.chomp
	#log "Look TED, all_output: #{all_output}"
	# dates look like this: Mon May 11 14:12:24 MDT 2015
	temp_output = all_commands.map { |c| c.output }.join("\n")
	if !temp_output.match(/Failed Login Attempts Report as of\s+([MTWFS][a-z][a-z])\s+([JFMASOND][a-z][a-z])\s+(\d{1,2})\s+(\d\d)\:(\d\d)\:(\d\d)\s+([A-Z]{3})\s+(\d{4})/)
		raise("#{temp_output} does not contain a valid date as produced by the Linux date command")	
	end
	yyyy = $8.to_i
	mon = ["", "Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"].index($2).to_i
	day = $3.to_i
	hour = $4.to_i
	minute = $5.to_i
	second = $6.to_i
	hisDate = Time.new(yyyy,mon,day,hour,minute,second)
	now = Time.now
	#log "His date: #{hisDate}"
	#log "My date: #{now}"
	#if (now - hisDate).abs > 60*60*24
	if (now - hisDate).abs > 60 
		raise("#{temp_output} does not contain a current date as produced by the Linux date command.  Now: #{now} His: #{hisDate}")	
	end
=end    
end


Given /^(.*) points are awarded/ do |points|
	#log "#{points} points are now awarded!!!"
	$total_points += points.to_i
end

Given /^timeout is increased by (.*) seconds$/ do |seconds|
	if @aruba_timeout_seconds  
		@aruba_timeout_seconds += seconds.to_i
	else
		@aruba_timeout_seconds = 3 + seconds.to_i
	end
end

Given /^timeout is decreased by (.*) seconds$/ do |seconds|
	if @aruba_timeout_seconds
		@aruba_timeout_seconds -= seconds.to_i
	else
		log "aruba_timeout_seconds is NIL!"
	end
end

