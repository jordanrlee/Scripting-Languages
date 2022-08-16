#@announce-output

Feature: Convert Fahrenheit to Celsius
	Scenario: Convert Fahrenheit to Celsius
		When I run `temp` interactively
		And I type "1"
		And I type a random degree fahrenheit between -3000.0 and 3000.0"
		And I type "3"
		Then the output should contain random degree fahrenheit converted to celsius
		When I run `temp` interactively
		And I type "1"
		And I type "32.0"
		And I type "3"
		Then the output should match /0.0\b/
		When I run `temp` interactively
		And I type "1"
		And I type "212.0"
		And I type "3"
		Then the output should match /100.0\b/
		When I run `temp` interactively
		And I type "1"
		And I type "-30.0"
		And I type "3"
		Then the output should match /-34.4\b/
		When I run `temp` interactively
		And I type "1"
		And I type "2000.3"
		And I type "3"
		Then the output should match /1093.5\b/
        And OUTPUT is printed
		Then 10 points are awarded

