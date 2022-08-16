Feature: Database contains correct information

	Scenario: Courses table exists and is defined correctly
		Given a random small CSV file "random10.csv"
		When I run `dbload "random10.csv" "people10.db"`
        And OUTPUT is printed
		Then the courses table in "people10.db" should be defined correctly
		Then 30 points are awarded

	Scenario: Peoples table exists and is defined correctly
		Given a random small CSV file "random11.csv"
		When I run `dbload "random11.csv" "people11.db"`
        And OUTPUT is printed
		Then the people table in "people11.db" should be defined correctly
		Then 30 points are awarded

	Scenario: people table should have the correct number of records
		Given a random small CSV file "random1.csv"
		When I run `dbload "random1.csv" "people1.db"`
        And OUTPUT is printed
		Then the count of people from "people1.csv" in "people1.db" should be correct
		Then 40 points are awarded

	Scenario: courses table should have the correct number of records
		Given a random small CSV file "random2.csv"
		When I run `dbload "random2.csv" "people2.db"`
        And OUTPUT is printed
		Then the count of courses from "people2.csv" in "people2.db" should be correct
		Then 40 points are awarded

	Scenario: People table contains correct information
		Given a random small CSV file "random3.csv"
		When I run `dbload "random3.csv" "people3.db"`
        And OUTPUT is printed
		Then the people table data from "random3.csv" in "people3.db" should be correct
		Then 50 points are awarded

	Scenario: Courses table contains correct information
		Given a random small CSV file "random4.csv"
		When I run `dbload "random4.csv" "people4.db"`
        And OUTPUT is printed
		Then the courses table data from "random4.csv" in "people4.db" should be correct
		Then 50 points are awarded

