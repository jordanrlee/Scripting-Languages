Feature: Program output should be correct
	Scenario: return code 1 if PATH missing
		Given the default aruba exit timeout is 30 seconds
		When I run `srpt`
        And OUTPUT is printed
		Then the exit status should be 1
		Then 10 points are awarded

	Scenario: header is correct
		Given the default aruba exit timeout is 30 seconds
		Given a folder of assorted files in testfiles
		When I run `srpt testfiles`
        And OUTPUT is printed
		And header contains SearchReport HOSTNAME PATH
		And header ends with the current date
		Then 10 points are awarded

	Scenario: directory count is correct
		Given the default aruba exit timeout is 30 seconds
		Given a folder of assorted files in testfiles
		When I run `srpt testfiles`
        And OUTPUT is printed
		And directory count is correct
		Then 10 points are awarded

	Scenario: file count is correct
		Given the default aruba exit timeout is 30 seconds
		Given a folder of assorted files in testfiles
		When I run `srpt testfiles`
        And OUTPUT is printed
		And file count is correct
		Then 10 points are awarded

	Scenario: symbolic link count is correct
		Given the default aruba exit timeout is 30 seconds
		Given a folder of assorted files in testfiles
		When I run `srpt testfiles`
        And OUTPUT is printed
		And symbolic link count is correct
		Then 10 points are awarded

	Scenario: graphics file count is correct
		Given the default aruba exit timeout is 30 seconds
		Given a folder of assorted files in testfiles
		When I run `srpt testfiles`
        And OUTPUT is printed
		And graphics file count is correct
		Then 10 points are awarded

	Scenario: count of files older than 365 days is correct
		Given the default aruba exit timeout is 30 seconds
		Given a folder of assorted files in testfiles
		When I run `srpt testfiles`
        And OUTPUT is printed
		And count of files older than 365 days is correct
		Then 10 points are awarded

	Scenario: large file count is correct
		Given the default aruba exit timeout is 30 seconds
		Given a folder of assorted files in testfiles
		When I run `srpt testfiles`
        And OUTPUT is printed
		And large file count is correct
		Then 10 points are awarded

	Scenario: temporary file count is correct
		Given the default aruba exit timeout is 30 seconds
		Given a folder of assorted files in testfiles
		When I run `srpt testfiles`
        And OUTPUT is printed
		And temporary file count is correct
		Then 10 points are awarded

	Scenario: executable file count is correct
		Given the default aruba exit timeout is 30 seconds
		Given a folder of assorted files in testfiles
		When I run `srpt testfiles`
        And OUTPUT is printed
		And executable file count is correct
		Then 10 points are awarded

	Scenario: total file count is correct
		Given the default aruba exit timeout is 30 seconds
		Given a folder of assorted files in testfiles
		When I run `srpt testfiles`
        And OUTPUT is printed
		And total file size is correct
		Then 10 points are awarded

	Scenario: execution time is < 5 seconds
		Given the default aruba exit timeout is 0 seconds
		Given a folder of assorted files in testfiles1
		When I successfully run `srpt testfiles1` for up to 5 seconds
		Given a folder of assorted files in testfiles2
		When I successfully run `srpt testfiles2` for up to 5 seconds
		Given a folder of assorted files in testfiles3
		When I successfully run `srpt testfiles3` for up to 5 seconds
        And OUTPUT is printed
		Then 40 points are awarded 

	Scenario: exit code is zero for normal execution
		Given the default aruba exit timeout is 30 seconds
		When I run `srpt .`
        And OUTPUT is printed
		Then the exit status should be 0
		Then 10 points are awarded
		
	Scenario: exit code is 1 for abnormal execution
		Given the default aruba exit timeout is 30 seconds
		When I run `srpt`
        And OUTPUT is printed
		Then the exit status should not be 0
		Then 10 points are awarded
		
	Scenario: Usage statement should be printed for abnormal execution
		Given the default aruba exit timeout is 30 seconds
		When I run `srpt`
        And OUTPUT is printed
		Then the output should contain "Usage"
		Then 10 points are awarded
		
