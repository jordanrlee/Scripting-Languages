#@announce-stderr

Feature: Program menu output should be correct
	Scenario: program prints the correct welcome message
		When I run `temp` interactively
		And I type "3"
        And OUTPUT is printed
		And the output should match:
		"""
		Welcome to the CS 3030 Temperature Conversion Program
		"""
		Then 5 points are awarded
		
	Scenario: program prints the main menu
		When I run `temp` interactively
		And I type "3"
		And the output should match:
		"""
		Main Menu
		\s*1.*Fahrenheit to [Cc]elsius
		\s*2.*Celsius to [Ff]ahrenheit
		\s*3.*Exit [Pp]rogram
		\s*
		\s*Please enter 1.*2.*3
		"""
        And OUTPUT is printed
		Then 5 points are awarded
		
