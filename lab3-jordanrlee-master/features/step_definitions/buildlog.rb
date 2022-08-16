#!/usr/bin/env ruby

# buildlog - generates a random log file for CS 3030 Lab 3 testing and keep stats

require 'date'
require 'time'
require 'set'
require_relative 'firstnames'

KNOWNUSERS = 30..50
USERSWITHSAMECOUNT = 3..5
USERSWITHLARGECOUNT = 3..5
UNKNOWNUSERCOUNT = 1..4000
SMALLCOUNT = 1..15
LARGECOUNT = 100..1500
UNKNOWNUSERENTRIES = 5000..15000

class Log < Struct.new(:userid, :count)
end

class BuildLog
	def initialize(path)
		f = FirstNames.new
		firstNames = f.firstNames
		if firstNames == nil
			raise ("firstNames is nil!")
		end
		@firstNames = firstNames
		@logFile = path
		@logFilePath = File.join('tmp/aruba', path)

		r = Random.new
		@knownUserCount = r.rand(KNOWNUSERS)
		@usersWithSameCount = r.rand(USERSWITHSAMECOUNT)
		@usersWithLargeCount = r.rand(USERSWITHLARGECOUNT)
		@unknownUserEntries = r.rand(UNKNOWNUSERENTRIES)
		#firstNames = File.readlines('./firstnames.txt')
		
		# create all of the users
		@knownUsers = Array.new
		namesUsed = Set.new([""])
		for i in 1..@knownUserCount
			# get a userid from the firstnames list
			f = r.rand(0..@firstNames.length-1)
			userid = @firstNames[f].chomp.downcase
			if namesUsed.include?(userid)
				redo
			end
			namesUsed.add(userid)
			count = r.rand(SMALLCOUNT)
			user = Log.new
			user.userid = userid
			user.count = count
			@knownUsers << user
		end
		# make a few of them large counts
		largeUsers = Set.new([""])
		for i in 1..@usersWithLargeCount
			u = r.rand(0..@knownUserCount-1)
			user = @knownUsers[u]
			# skip those already made large 
			if largeUsers.include?(user.userid)
				#log "Large: already using #{user.userid} with count #{user.count}"
				redo
			end
			user.count = r.rand(LARGECOUNT)
			largeUsers.add(user.userid)
		end
		# generate the file of known user log entries
		logfile = File.open(@logFilePath, "w")
		for u in @knownUsers
			for i in 1..u.count
				logfile.write("Dec 25 07:00:00 localhost sshd[1234]: Failed password for #{u.userid} from 123.12.1.2 port 12345 ssh2\n")
			end
		end
		# add to the file the unknown entries
		for i in 1..@unknownUserEntries
			logfile.write("Dec 25 07:00:00 localhost sshd[1234]: Failed password for invalid user notauser from 123.12.1.3 port 12346 ssh2\n")
		end
		logfile.close()
		unknown = Log.new("<UNKNOWN>",@unknownUserEntries)
		@knownUsers << unknown
		@knownUsers = @knownUsers.sort_by{|u| [-u.count, u.userid]}
		#log knownUsers
		
	end
	
	def logFile
		return @logFile
	end
	
	def logFilePath
		return @logFilePath
	end
	
	def users
		return @knownUsers
	end
	
end
