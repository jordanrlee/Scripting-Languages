Feature: Script must be named "filemaker", present and be marked as executable
	Scenario: filemaker must be found
		When I run `getfile` 
		Then a file named "../../bin/filemaker" should exist
		Then 5 points are awarded

	Scenario: filemaker must be executable
		When I run `filemaker`
        And OUTPUT is printed
		Then 5 points are awarded
