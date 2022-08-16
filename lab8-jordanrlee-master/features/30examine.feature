#@announce-output

Feature: Database contains correct information

Background: Script must be named "dbload" (copies dlls as well)
		When I run `getfile` 
		Then a file named "../../bin/dbload.ps1" should exist


	Scenario: Courses table exists and is defined correctly
		Given a random small CSV file "random10.csv"
		When I run `dbload.ps1 "random10.csv" "students10.db"`
        And OUTPUT is printed
		Then the courses table in "students10.db" should be defined correctly
		Then 30 points are awarded

	Scenario: People table exists and is defined correctly
		Given a random small CSV file "random11.csv"
		When I run `dbload.ps1 "random11.csv" "students11.db"`
        And OUTPUT is printed
		Then the people table in "students11.db" should be defined correctly
		Then 30 points are awarded

	Scenario: People table should have the correct number of records
		Given a random small CSV file "random1.csv"
		When I run `dbload.ps1 "random1.csv" "students1.db"`
        And OUTPUT is printed
		Then the count of people from "students1.csv" in "students1.db" should be correct
		Then 40 points are awarded

	Scenario: courses table should have the correct number of records
		Given a random small CSV file "random2.csv"
		When I run `dbload.ps1 "random2.csv" "students2.db"`
        And OUTPUT is printed
		Then the count of courses from "students2.csv" in "students2.db" should be correct
		Then 40 points are awarded

	Scenario: People table contains correct information
		Given a random small CSV file "random3.csv"
		When I run `dbload.ps1 "random3.csv" "students3.db"`
        And OUTPUT is printed
		Then the people table data from "random3.csv" in "students3.db" should be correct
		Then 50 points are awarded

	Scenario: Courses table contains correct information
		Given a random small CSV file "random4.csv"
		When I run `dbload.ps1 "random4.csv" "students4.db"`
        And OUTPUT is printed
		Then the courses table data from "random4.csv" in "students4.db" should be correct
		Then 50 points are awarded

