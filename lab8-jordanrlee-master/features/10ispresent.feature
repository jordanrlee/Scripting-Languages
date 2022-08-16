Feature: Script must be named "dbload.ps1", present and be marked as executable
	Scenario: dbload.ps1 must be found
		When I run `getfile` 
		Then a file named "../../bin/dbload.ps1" should exist
		Then 5 points are awarded

	Scenario: dbload must be executable
		When I run `dbload.ps1`
        And OUTPUT is printed
		Then 5 points are awarded
