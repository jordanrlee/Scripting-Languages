$total_points = 0

Before do
	# puts Dir.pwd
	ENV['LIBC_FATAL_STDERR_'] = "1"
end

at_exit do
	puts "A total of #{$total_points} points have been awarded."
	running = `ps ef` 
	if running =~ /python.+lab4.temp/
		puts "*** one or more temp processes are still running"
		#puts running
		puts "*** Issuing \"killall python\""
		`killall python`
	end
end
