Feature: Script must be named "dbload", present and be marked as executable
	Scenario: dbload must be found
		When I run `getfile` 
		Then a file named "../../bin/dbload" should exist
		Then 5 points are awarded

	Scenario: dbload must be executable
		When I run `dbload`
        And OUTPUT is printed
		Then 5 points are awarded
