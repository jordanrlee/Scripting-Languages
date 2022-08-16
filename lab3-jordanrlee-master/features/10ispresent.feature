Feature: Script must be named "flog", present and be marked as executable
	Scenario: flog must be found
		When I run `getfile` 
		Then a file named "../../bin/flog" should exist
		Then 10 points are awarded

	Scenario: flog must be executable
		When I run `flog` 
        And OUTPUT is printed
		Then 10 points are awarded
