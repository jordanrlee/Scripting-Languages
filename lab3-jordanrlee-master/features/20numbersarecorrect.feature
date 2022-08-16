Feature: Program output should be correct
	Scenario: exit code is zero for normal execution
		Given a random logfile named log2
		Given timeout is increased by 60 seconds
		When I run `flog log2`
        And OUTPUT is printed
		Then the exit status should be 0
		Then 10 points are awarded
		
	Scenario: exit code is 1 if PATH is missing
		When I run `flog`
        And OUTPUT is printed
		Then the exit status should be 1
		Then 10 points are awarded
		
	Scenario: Usage statement should be printed for abnormal execution
		When I run `flog`
        And OUTPUT is printed
		Then the output should contain "Usage"
		Then 10 points are awarded

	Scenario: header is in the correct format
		Given a random logfile named log1
		Given timeout is increased by 60 seconds
		When I run `bash -c 'flog log1 | lynx -nomargins -stdin -dump'`
        And OUTPUT is printed
		And header contains "Failed Login Attempts Report as of"
		And header ends with the current date
		Then 20 points are awarded

	Scenario: output is in HTML format
		Given a random logfile named log1
		Given timeout is increased by 60 seconds
		When I run `flog log1`
        And OUTPUT is printed
		Then the output should match:
		"""
		<html>.*</html>
		"""
		And the output should match:
		"""
		<h1>.*</h1>
		"""
		And the output should match:
		"""
		<body>.*</body>
		"""
		And the output should match:
		"""
		<br />
		"""
		Then 30 points are awarded

	Scenario: UNKNOWN should be present and just below the header
		Given a random logfile named log2
		Given timeout is increased by 60 seconds
		When I run `bash -c 'flog log2 | lynx -nomargins -stdin -dump'`
        And OUTPUT is printed
		Then the output should match:
		"""
		[ \t]+Failed Login Attempts Report as of .+

		[,0-9]+[ \t]+<UNKNOWN>
		"""
		Then 40 points are awarded

	Scenario: The output should be correct
		Given a random logfile named log3
		Given timeout is increased by 60 seconds
		When I run `bash -c 'flog log3 | lynx -nomargins -stdin -dump'`
        And OUTPUT is printed
		Then the output should be sorted and complete
		Then 30 points are awarded


	Scenario: Large numbers should contain commas
		Given a random logfile named log3
		Given timeout is increased by 60 seconds
		When I run `bash -c 'flog log3 | lynx -nomargins -stdin -dump'`
        And OUTPUT is printed
		And large numbers are punctuated with commas
		Then 30 points are awarded

