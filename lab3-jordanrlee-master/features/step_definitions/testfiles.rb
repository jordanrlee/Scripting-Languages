# testfiles.rb - creates a random number of:
#   files - from 50 up to 500, all with zero length
#	largefiles - from 1 to 20 files, all greater than 512k
#	folders - from 30 to 60 nested, all named folderNN
#	graphics files - from 1 to 20 files renamed with .gif, .jpg, .bmp, all of zero length
#	temp files - some files renamed .o, all of zero length
#	executable files - some files chmod with --x--x--x, all of zero length
#	symlinks - from 5 to 30 files, in the same folder as the files, named #{file}sym
#	oldfiles - touching from 10 up to 30 files with dates > 2 years old
#
require 'date'
require 'time'

TOPLEVELFOLDERS = 1..10
FOLDERS = 30..60
FILES = 250..10000
FILESIZES = 1..20
LARGEFILES = 0..50
GRAPHICSFILES = 0..20
TEMPFILES = 0..20
EXECUTABLEFILES = 0..20
SYMLINKS = 0..20
OLDFILES = 0..30

class TestFiles
	def initialize(folder)
		@topFolder = folder
		@topFolderPath = File.join('tmp/aruba', folder)
		if Dir.exists?(@topFolderPath)
			`rm -rf #{@topFolderPath}`
		end
		#puts "ENV: #{ENV['home']}"
		Dir.mkdir(@topFolderPath, 0700)
		@folders = makeFolders(@topFolderPath)
		@files, @fileSizes = makeFiles(@folders)
		@largeFiles = makeLargeFiles(@files, @fileSizes)
		@graphicsFiles = makeGraphicsFiles(@files)
		@tempFiles = makeTempFiles(@files)
		@executableFiles = makeExecutableFiles(@files)
		@symlinks = makeSymlinks(@files)
		@oldFiles = makeOldFiles(@files)
	end
	def topFolder
		return @topFolder
	end
	
	# folders nested a few levels deep
	def makeFolders(topFolder)
		r = Random.new
		totalFolders = r.rand(FOLDERS)
		#puts "Creating #{totalFolders} folders"
		folders = Array.new
		#folders[0] = "InvalidFolderName" # skip the zero entry
		# make a few top level folders so we have a place to start
		topLevelFolderCount = r.rand(TOPLEVELFOLDERS)
		for i in 1..topLevelFolderCount
			name = File.join(topFolder, "folder#{i}")
			Dir.mkdir(name, 0700)
			folders << name
		end
		for i in topLevelFolderCount+1..totalFolders
			parent = r.rand(0..folders.size-1)
			name = File.join(folders[parent], "folder#{i}")
			Dir.mkdir(name, 0700)
			folders << name
		end
		return folders
	end
	def folders
		return @folders
	end
	
	# make a bunch of files, some with non-zero length
	def makeFiles(folders)
		r = Random.new
		totalFiles = r.rand(FILES)
		files = Array.new
		fileSizes = Array.new
		for i in 0..totalFiles-1
			folderNumber = r.rand(0..folders.size-1)
			folder = folders[folderNumber]
			file = File.join(folder, "file#{i}")
			File.open(file, "w") {}
			files << file
			if r.rand(0..50) == 5
				randomSize = r.rand(FILESIZES)
				File.truncate(file, randomSize)
				fileSizes[i] = randomSize
			else
				fileSizes[i] = 0
			end
		end
		return files, fileSizes
	end
	def files
		return @files
	end
	def totalFileSize
		totalFileSize = 0
		for i in 0..@fileSizes.count-1
			totalFileSize = totalFileSize + @fileSizes[i]
		end
		#totalFileSizeWithCommas = sprintf('%d', totalFileSize).gsub(/(\d)(?=(\d\d\d)+(?!\d))/, "\\1,")
		#return totalFileSizeWithCommas
		return totalFileSize
	end
	
	# from 1 to 20 large file from existing files, > 512k in size
	def makeLargeFiles(files, fileSizes)
		r = Random.new
		totalLargeFiles = r.rand(LARGEFILES)
		largeFiles = Array.new
		for i in 1..totalLargeFiles
			fileNumber = r.rand(0..files.size-1)
			file = files[fileNumber]
			if fileSizes[fileNumber] > 500000
				#puts "LargeFiles redo #{file}"
				redo
			end
			#cmd = "dd if=/dev/zero of=#{file} count=513 bs=1024 status=none"
			#cmd = "dd if=/dev/zero of=#{file} count=513 bs=1024 2&>1 >/dev/null"
			cmd = "dd if=/dev/zero of=#{file} count=513 bs=1024"
			#puts cmd
			`#{cmd} 2>&1 >/dev/null`
			#`#{cmd}`
			largeFiles << file
			fileSizes[fileNumber] = 513*1024
		end
		return largeFiles
	end
	def largeFiles
		return @largeFiles
	end

	# from 1 to 20 graphics files from existing files (skip existing graphics/.o files)
	def makeGraphicsFiles(files)
		r = Random.new
		totalGraphicsFiles = r.rand(GRAPHICSFILES)
		graphicsFiles = Array.new
		for i in 1..totalGraphicsFiles
			fileNumber = r.rand(0..files.size-1)
			oldname = files[fileNumber]
			if oldname.include?(".jpg") or
				oldname.include?(".bmp") or
				oldname.include?(".gif") or
				oldname.include?(".o")
				#puts "Graphics redo: #{oldname}"
				redo
			end
			suffix = [".jpg", ".bmp", ".gif"][r.rand(0..2)]
			newname = "#{oldname}#{suffix}"
			#puts "Old:#{oldname} New:#{newname}"
			File.rename(oldname, newname)
			files[fileNumber] = newname 
			graphicsFiles << newname
		end
		return graphicsFiles
	end
	def graphicsFiles
		return @graphicsFiles
	end

	# from 1 to 20 temp files from existing files (skip the graphics and .o files)
	def makeTempFiles(files)
		r = Random.new
		totalTempFiles = r.rand(TEMPFILES)
		tempFiles = Array.new
		for i in 1..totalTempFiles
			fileNumber = r.rand(0..files.size-1)
			oldname = files[fileNumber]
			if oldname.include?(".jpg") or
				oldname.include?(".bmp") or
				oldname.include?(".gif") or
				oldname.include?(".o")
				#puts "Temp redo: #{oldname}"
				redo
			end
			newname = "#{oldname}.o"
			#puts "Old:#{oldname} New:#{newname}"
			File.rename(oldname, newname)
			files[fileNumber] = newname 
			tempFiles << newname
		end
		return tempFiles
	end
	def tempFiles
		return @tempFiles
	end

	# from 1 to 20 executable files from any existing files with no dups
	def makeExecutableFiles(files)
		r = Random.new
		totalExecutableFiles = r.rand(EXECUTABLEFILES)
		executableFiles = Array.new
		for i in 1..totalExecutableFiles
			fileNumber = r.rand(0..files.size-1)
			name = files[fileNumber]
			if executableFiles.include?(name)
				redo
			end
			File.chmod(0755, name)
			#puts "Executable: :#{name}"
			executableFiles << name
		end
		return executableFiles
	end
	def executableFiles
		return @executableFiles
	end

	# from 1 to 20 symbolic links from any existing files to a different folder
	def makeSymlinks(files)
		r = Random.new
		totalSymlinks = r.rand(SYMLINKS)
		symlinks = Array.new
		for i in 1..totalSymlinks
			fileNumber = r.rand(0..files.size-1)
			name = files[fileNumber]
			baseName = File.basename(name) 
			symDirNumber = r.rand(0..@folders.size-1)
			symDir = folders[symDirNumber]
			symName = File.join(symDir, baseName)
			if symlinks.include?(symName) or symName == name
				#puts "symlink redo: #{symName}"
				redo
			end
			File.symlink(name, symName)
			#puts "Symlink: :#{symName} of #{name}"
			symlinks << symName
		end
		return symlinks
	end
	def symlinks
		return @symlinks
	end

	# from 0 to 30 old files from any existing files
	def makeOldFiles(files)
		r = Random.new
		totalOldFiles = r.rand(OLDFILES)
		oldFiles = Array.new
		for i in 1..totalOldFiles
			fileNumber = r.rand(0..files.size-1)
			name = files[fileNumber]
			if oldFiles.include?(name)
				redo
			end
			now = Time.now
			oldDate = now - (((60*60*24*365) * r.rand(1..5) + (60*60*24)))
			dateString = oldDate.strftime("%Y%m%d%H%M.%S")	
			cmd = "touch -t #{dateString} #{name}"	
			`#{cmd}`	
			#puts "Old file date:#{dateString}: #{name}"
			oldFiles << name
		end
		return oldFiles
	end
	def oldFiles
		return @oldFiles
	end

end

#puts "Folders:\n", testFiles.folders
#puts "Files:\n", testFiles.files
#puts "Large files:\n", testFiles.largeFiles

#puts "Directories: #{testFiles.folders.count}", 
#	" Files: #{testFiles.files.count}",
#	" Sym links: #{testFiles.symlinks.count}",
#	" Old Files: #{testFiles.oldFiles.count}",
#	" Large files: #{testFiles.largeFiles.count}",
#	" Graphics: #{testFiles.graphicsFiles.count}",
#	" Temporar files: #{testFiles.tempFiles.count}",
#	" Executable files: #{testFiles.executableFiles.count}",
#	#" Total File Size: #{sprintf("%'2d", testFiles.totalFileSize)}"
#	" TotalFileSize: #{totalFileSize}"
		
