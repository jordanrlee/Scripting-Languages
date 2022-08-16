#@announce-output

Feature: Alpha characters should not crash the program
	Scenario: Menu should survive being handed a non-number
		When I run `temp` interactively
		And I type "fooie"
		And I type "3"
		And I type "3"
		And I type "3"
		Then the output should not contain "ValueError"
        And OUTPUT is printed
		Then 10 points are awarded

	Scenario: Celsius survives a non-number
		When I run `temp` interactively
		And I type "2"
		And I type "fooie"
		And I type "3"
		And I type "3"
		Then the output should not contain "ValueError"
        And OUTPUT is printed
		Then 10 points are awarded

	Scenario: Fahrenheit survives a non-number
		When I run `temp` interactively
		And I type "1"
		And I type "fooie"
		And I type "3"
		And I type "3"
		Then the output should not contain "ValueError"
        And OUTPUT is printed
		Then 10 points are awarded

