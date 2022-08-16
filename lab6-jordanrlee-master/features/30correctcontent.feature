Feature: Output file contains correct information

	Scenario: Script outputs the correct number of records
		Given a file named "smallcmd" with:
			"""
			STRING "testing 1 2 3\n"
			"""
		When I run `filemaker smallcmd smalloutput 3`
        And OUTPUT is printed
		Then the file "smalloutput" should contain:
			"""
			testing 1 2 3
			testing 1 2 3
			testing 1 2 3
			"""
		Then 30 points are awarded

	Scenario: Script supports the HEADER command
		Given a file named "headercmd" with:
			"""
			HEADER "This is a header	with an imbedded tab character\n"
			STRING "just a string\n"
			"""
		When I run `filemaker headercmd headeroutput 2`
        And OUTPUT is printed
		Then the file "headeroutput" should contain:
			"""
			This is a header	with an imbedded tab character
			just a string
			just a string
			"""
		Then 30 points are awarded

	Scenario: Script supports the STRING command
		Given a file named "anotherstringcmd" with:
			"""
			STRING "yet another string\n"
			"""
		When I run `filemaker anotherstringcmd anotherstringoutput 3`
        And OUTPUT is printed
		Then the file "anotherstringoutput" should contain:
			"""
			yet another string
			"""
		Then 40 points are awarded

	Scenario: Script supports the WORD command
		Given a file named "filewordcmd" with:
			"""
			WORD wordfilelabel "words"
			"""
		Given a file named "words" with:
			"""
			one
			two
			three
			four
			five

			"""
		When I run `filemaker filewordcmd filewordoutput 1`
        And OUTPUT is printed
		Then the file "filewordoutput" should match /one|two|three|four|five/
		Then 20 points are awarded

	Scenario: Script supports the WORD command with true randomness
		Given a file named "randomfilewordcmd" with:
			"""
			WORD randomwordlabel "randomwords"
			STRING "\n"
			"""
		Given a file named "randomwords" with:
			"""
			your
			lack
			of
			faith
			is
			disturbing

			"""
		When I run `filemaker randomfilewordcmd randomfilewordoutput 5`
        And OUTPUT is printed
		Then the exit status should be 0
		Then the file "randomfilewordoutput" should not match /(\w+)\n\1\n\1\n\1\n\1\n/
		Then 20 points are awarded

	Scenario: Script supports the INTEGER command
		Given a file named "numbercmd" with:
			"""
			INTEGER numlabel 1 1999
			STRING "\n"
			"""
		When I run `filemaker numbercmd numberoutput 3`
        And OUTPUT is printed
		Then the file "numberoutput" should match /^\d+\n\d+\n\d+/
		Then 20 points are awarded

	Scenario: Script supports the INTEGER command with true randomness
		Given a file named "randomnumbercmd" with:
			"""
			INTEGER anothernumlabel 1 1999
			STRING "\n"
			"""
		When I run `filemaker randomnumbercmd randomnumberoutput 5`
        And OUTPUT is printed
		Then the exit status should be 0
		Then the file "randomnumberoutput" should not match /(\d+)\n\1\n\1\n\1\n\1\n/
		Then 20 points are awarded

	Scenario: Script supports the REFER command to a label on a WORD command
		Given a file named "morewords" with:
			"""
			this
			is
			a
			test

			"""
		Given a file named "referfilewordcmd" with:
			"""
			WORD referlabel "morewords"
			STRING " and "
			REFER referlabel
			STRING " and "
			REFER referlabel
			"""
		When I run `filemaker referfilewordcmd referfilewordoutput 1`
        And OUTPUT is printed
		Then the file "referfilewordoutput" should match /^(\w+) and \1 and \1$/
		Then 30 points are awarded

	Scenario: Script supports the REFER command to a label on a INTEGER command
		Given a file named "refernumbercmd" with:
			"""
			INTEGER somenum 1 99999
			STRING " I said "
			REFER somenum
			STRING " I said "
			REFER somenum
			"""
		When I run `filemaker refernumbercmd refernumberoutput 1`
        And OUTPUT is printed
		Then the file "refernumberoutput" should match /^(\d+) I said \1 I said \1$/
		Then 30 points are awarded

