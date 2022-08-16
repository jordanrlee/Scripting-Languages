#!/usr/bin/env pwsh
# Jordan Lee
# Lab 8 - PowerShell Database Loader
# CS 3030 - Scripting Languages

# Prepare for the PowerShell code.

# check the file before creation
# exit on 1 if error with file creation
if ($args.count -ne 2) {
Write-Host "Usage: ./dbload.ps1 INPUTCSV OUTPUTDB"
exit(1)
}
try {
$csv = import-csv $args[0] -delimiter ","
}
catch {
Write-Host ("Error opening CSV file: $_")
exit(1)
}
try {
Add-Type -Path "dlls/System.Data.SQLite.dll"
$con = New-Object -TypeName System.Data.SQLite.SQLiteConnection
$con.ConnectionString = "Data Source=$($args[1])"
$con.Open()
}
catch {
Write-Host("Error opening database file: $_")
exit(1)
}
$transaction = $con.BeginTransaction("create")
# run a DROP on the table if people already found
$sql = $con.CreateCommand()
$sql.CommandText = 'DROP table if exists people'
[void]$sql.ExecuteNonQuery()
# run CREATE on table people
# use values ID, LASTNAME, FIRSTNAME, EMAIL, MAJOR, CITY, STATE, ZIP
$sql.CommandText = 'CREATE table people (id text primary key unique,lastname text,
firstname text, major text, email text, city text, state text, zip text);'
[void]$sql.ExecuteNonQuery()
# run a DROP on the table if courses already found
$sql = $con.CreateCommand()
$sql.CommandText = 'DROP table if exists courses'
[void]$sql.ExecuteNonQuery()
# run CREATE on table courses
# provide ID, SUBJCODE, COURSENUMBER, TERMCODE 
$sql.CommandText = 'CREATE table courses (id text, subjcode text, coursenumber
text, termcode text);'
[void]$sql.ExecuteNonQuery()
[void]$transaction.Commit()
# split the string 
foreach ($row in $csv){
$s = $row.course.split(" ")
$transaction = $con.BeginTransaction("addpersontransaction")
$sql.CommandText = "INSERT or REPLACE into people
(id,firstname,lastname,email,major,city,state,zip)
values(@id,@firstname,@lastname,@email,@major,@city,@state,@zip);"
[void]$sql.Parameters.AddWithValue("@id", $row.wnumber)
[void]$sql.Parameters.AddWithValue("@firstname", $row.firstname)
[void]$sql.Parameters.AddWithValue("@lastname", $row.lastname)
[void]$sql.Parameters.AddWithValue("@email", $row.email)
[void]$sql.Parameters.AddWithValue("@major", $row.major)
[void]$sql.Parameters.AddWithValue("@city", $row.city)
[void]$sql.Parameters.AddWithValue("@state", $row.state)
[void]$sql.Parameters.AddWithValue("@zip", $row.zip)
[void]$sql.ExecuteNonQuery()
[void]$transaction.Commit()
# all people table is committed to the database
$transaction = $con.BeginTransaction("addpersontransaction")
$sql.CommandText = "INSERT into courses (id,subjcode,coursenumber,termcode)
values(@id,@subjcode,@coursenumber,@termcode);"
[void]$sql.Parameters.AddWithValue("@id", $row.wnumber)
[void]$sql.Parameters.AddWithValue("@subjcode", $s[0])
[void]$sql.Parameters.AddWithValue("@coursenumber", $s[1])
[void]$sql.Parameters.AddWithValue("@termcode", $row.termcode)
[void]$sql.ExecuteNonQuery()
[void]$transaction.Commit()
# all course table is committed to the database
}
exit(0)

# end PowerShell Code
