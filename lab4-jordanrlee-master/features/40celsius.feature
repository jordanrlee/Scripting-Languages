#@announce-output

Feature: Convert Celsius to Fahrenheit
	Scenario: Convert Celsius to Fahrenheit
        When I run `temp` interactively
        And I type "2" 
        And I type a random degree celsius between -3000.0 and 3000.0"
        And I type "3" 
        Then the output should contain random degree celsius converted to fahrenheit
	
		When I run `temp` interactively
		And I type "2"
		And I type "0"
		And I type "3"
		Then the output should match /32.0\b/

		When I run `temp` interactively
		And I type "2"
		And I type "100.0"
		And I type "3"
		Then the output should match /212.0\b/

		When I run `temp` interactively
		And I type "2"
		And I type "-13.0"
		And I type "3"
		Then the output should match /8.6\b/

		When I run `temp` interactively
		And I type "2"
		And I type "-3092.0"
		And I type "3"
		Then the output should match /-5533.6\b/

        And OUTPUT is printed
		Then 10 points are awarded

