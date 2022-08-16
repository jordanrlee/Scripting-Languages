#@announce-output

Feature: Exit program
	Scenario: Exit program with menu option 3
		When I run `temp` interactively
		And I type "3"
		And the output should match:
		"""
		Welcome to the CS 3030 Temperature Conversion Program
		"""
        And OUTPUT is printed
		Then the exit status should be 0
		Then 10 points are awarded

