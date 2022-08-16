# commas.rb


def commas(number)
	return sprintf('%d', number).gsub(/(\d)(?=(\d\d\d)+(?!\d))/, "\\1,")
end
