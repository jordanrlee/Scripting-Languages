#@announce-output

Feature: Script must be named "temp", present and be marked as executable
	Scenario: temp must be found
		When I run `getfile` 
		Then a file named "../../bin/temp" should exist
		Then 5 points are awarded

	Scenario: temp must be executable
		When I run `temp` interactively
		And I type "3"
        And the output should match:
        """
        Welcome to the CS 3030 Temperature Conversion Program
        """
        And OUTPUT is printed
		Then 5 points are awarded
