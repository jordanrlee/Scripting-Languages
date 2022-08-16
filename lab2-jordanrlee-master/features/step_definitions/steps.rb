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


Given /^a folder of assorted files in (.*)/ do |folder|
	@testFiles = TestFiles.new(folder)
	#log "Top folder: #{@testFiles.topFolder}"
end

Given /^header contains SearchReport HOSTNAME PATH$/ do
	hostname = `hostname`.chomp
	#step "the output should match /SearchReport\s+#{hostname}\s+#{@testFiles.topFolder}/"
	#if !all_output.match(/SearchReport\s+#{hostname}\s+#{@testFiles.topFolder}/)
	temp_output = all_commands.map { |c| c.output }.join("\n")
	if !temp_output.match(/SearchReport\s+#{hostname}\s+#{@testFiles.topFolder}/)
		raise("#{temp_output} does not contain SearchReport #{hostname} #{@testFiles.topFolder}")	
	end
end

Given /^header ends with the current date$/ do
=begin
	date = `date`.chomp
	hostname = `hostname`.chomp
	#log "Look TED, all_output: #{all_output}"
	# dates look like this: Mon May 11 14:12:24 MDT 2015
	temp_output = all_commands.map { |c| c.output }.join("\n")
	if !temp_output.match(/SearchReport\s+#{hostname}\s+#{@testFiles.topFolder}\s+([MTWFS][a-z][a-z])\s+([JFMASOND][a-z][a-z])\s+([ \d]\d)\s+(\d\d)\:(\d\d)\:(\d\d)\s+([A-Z]{3})\s+(\d{4})/)
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
		raise("#{all_output} does not contain a current date as produced by the Linux date command")	
	end
=end    
end

Given /^directory count is correct$/ do
	step "the output should contain \"Directories #{commas(@testFiles.folders.count)}\""
end

Given /^file count is correct$/ do
	step "the output should contain \"Files #{commas(@testFiles.files.count)}\""
end

Given /^symbolic link count is correct$/ do
	step "the output should contain \"Sym links #{commas(@testFiles.symlinks.count)}\""
end

Given /^graphics file count is correct$/ do
	step "the output should contain \"Graphics files #{commas(@testFiles.graphicsFiles.count)}\""
end

Given /^count of files older than 365 days is correct$/ do
	step "the output should contain \"Old files #{commas(@testFiles.oldFiles.count)}\""
end

Given /^large file count is correct$/ do
	step "the output should contain \"Large files #{commas(@testFiles.largeFiles.count)}\""
end

Given /^temporary file count is correct$/ do
	step "the output should contain \"Temporary files #{commas(@testFiles.tempFiles.count)}\""
end

Given /^executable file count is correct$/ do
	step "the output should contain \"Executable files #{commas(@testFiles.executableFiles.count)}\""
end

Given /^total file size is correct$/ do
	step "the output should contain \"TotalFileSize #{commas(@testFiles.totalFileSize)}\""
end

Given /^the output should contain PWD$/ do 
	#log ENV['PWD']
	#log ENV['HOME']
	#log @dirs.join("/")
	#step "the output should match /" + Regexp.escape(ENV['PWD']) + "/"
	step "the output should contain \"" +  ENV['PWD'] + "/" + @dirs.join("/") + "\""
end

Given /^(.*) points are awarded/ do |points|
	#log "#{points} points are now awarded!!!"
	$total_points += points.to_i
end

Given /^dot is replaced with PWD\/(.*)$/ do |outputfile|
	step "the output should contain \"copy #{outputfile} #{ENV['PWD']}\/#{File.join(@dirs)}\/#{outputfile}\""
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



