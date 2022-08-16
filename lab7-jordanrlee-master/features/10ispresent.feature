#@announce-output

Feature: Script must be present and be executable
	Scenario: srpt must be found
		When I run `getfile` 
		Then a file named "../../bin/srpt.ps1" should exist
		Then 10 points are awarded

	Scenario: srpt must be executable
		When I run `srpt.ps1` 
        And OUTPUT is printed
		Then 10 points are awarded
