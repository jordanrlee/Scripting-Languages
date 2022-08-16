Feature: Creates an output file according to the commandfile and record count

	Scenario: With parameters missing, "Usage:" msg and exits with rc=1
		When I run `filemaker`
        And OUTPUT is printed
		And the output should match /[Uu]sage:/
		Then the exit status should be 1
		Then 10 points are awarded

	Scenario: If input command file cannot be opened, "Error" msg and exits with rc=1
		Given an empty file named "cannotopen.txt" with mode "0000"
		When I run `filemaker cannotopen.csv unimportant.output 3`
        And OUTPUT is printed
		And the output should match /[Ee]rror/
		Then the exit status should be 1
		Then 10 points are awarded

	Scenario: If output file cannot be opened,  "Error" msg and exits with rc=1
		Given an empty file named "emptyinputfile"
		Given an empty file named "cannotoverwrite" with mode "0000"
		When I run `filemaker emptyinputfile cannotoverwrite 3`
        And OUTPUT is printed
		And the output should match /[Ee]rror/
		Then the exit status should be 1
		Then 10 points are awarded

	Scenario: Returns rc=1 and "Error" message if count is not a number
		Given an empty file named "emptyinputfile"
		When I run `filemaker emptyinputfile unimportant.output notanumber`
        And OUTPUT is printed
		Then the exit status should be 1
		And the output should match /[Ee]rror/
		Then 10 points are awarded

	Scenario: Returns rc=0 on successful run
		Given a file named "smallcmd" with:
			"""
			STRING "hello, world!\n"
			"""
		When I run `filemaker smallcmd smalloutput 3`
        And OUTPUT is printed
		Then the file "smalloutput" should contain:
			"""
			hello, world!
			hello, world!
			hello, world!
			"""
		Then the exit status should be 0
		Then 10 points are awarded

