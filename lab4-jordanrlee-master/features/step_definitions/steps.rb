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

Given /^header contains "(.*?)"$/ do |arg1|
	#step "the output should match /SearchReport\s+#{hostname}\s+#{@testFiles.topFolder}/"
	if !all_output.match(/#{arg1}/)
		raise("Output <#{all_output}> does not contain \"#{arg1}\"")	
	end
end

Given /^I type a random degree fahrenheit between (.*) and (.*)$/ do |min, max|
	r = Random.new
	@randomFahrenheit = r.rand(min.to_f..max.to_f).round(1)
	@randomCelsius = (@randomFahrenheit - 32.0) * (5.0/9.0)
	@randomFahrenheit = sprintf('%.1f', @randomFahrenheit)
	@randomCelsius = sprintf('%.1f', @randomCelsius)
	log "Random #{@randomFahrenheit} degrees Fahrenheit = #{@randomCelsius} degrees Celsius"
	step "I type \"#{@randomFahrenheit}\""
end

Given /^the output should contain random degree fahrenheit converted to celsius$/ do
	step "the output should match /#{@randomCelsius}\\b/"
end

Given /^I type a random degree celsius between (.*) and (.*)$/ do |min, max|
	r = Random.new
	@randomCelsius = r.rand(min.to_f..max.to_f).round(1)
	@randomFahrenheit = (9.0/5.0) * @randomCelsius + 32.0
	@randomFahrenheit = sprintf('%.1f', @randomFahrenheit)
	@randomCelsius = sprintf('%.1f', @randomCelsius)
	log "Random #{@randomCelsius} degrees Celsius = #{@randomFahrenheit} degrees Fahrenheit"
	step "I type \"#{@randomCelsius}\""
end

Given /^the output should contain random degree celsius converted to fahrenheit$/ do
	step "the output should match /#{@randomFahrenheit}\\b/"
end

Given /^large numbers are punctuated with commas/ do
	users = @log.users
	# remove the first two rows
	output = Array.new
	output = all_output.split("\n")
	savedOutput = Array.new
	savedOutput = all_output.split("\n")
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

