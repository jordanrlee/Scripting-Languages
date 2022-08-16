#@announce-output

Feature: 
	Scenario: fahrenheitToCelsius() is defined and used
		When I run `cat ../../bin/temp`
		Then the output should match:
		"""
		^[ \t]*def fahrenheitToCelsius\(
		"""
		And the output should match:
		"""
		.*fahrenheitToCelsius\(.*fahrenheitToCelsius\(
		"""
		Then 10 points are awarded 

	Scenario: celsiusToFahrenheit() is defined and used
		When I run `cat ../../bin/temp`
		Then the output should match:
		"""
		^[ \t]*def celsiusToFahrenheit\(
		"""
		And the output should match:
		"""
		.*celsiusToFahrenheit\(.*celsiusToFahrenheit\(
		"""
		Then 10 points are awarded 

