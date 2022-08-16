# commas.rb


def commas(number)
	parts = number.to_s.split("\.")
	if parts.length == 1
		log "No periods"
		return sprintf('%d', number).gsub(/(\d)(?=(\d\d\d)+(?!\d))/, "\\1,")
	else 
		log "found a period"
		return sprintf('%d', parts[0]).gsub(/(\d)(?=(\d\d\d)+(?!\d))/, "\\1,") + "." + parts[1]
	end
end
